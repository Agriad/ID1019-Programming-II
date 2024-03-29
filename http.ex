defmodule HTTP do
    def parse_request(r0) do
        {request, r1} = request_line(String.to_charlist(r0))
        {headers, r2} = headers(r1)
        {body, _} = message_body(r2)
        {request, headers, body}
    end

    def request_line([?G, ?E, ?T, 32 | r0]) do
        {uri, r1} = request_uri(r0)
        {ver, r2} = http_version(r1)
        [13, 10 | r3] = r2
        {{:get, uri, ver}, r3}
    end

    def request_uri([32 | r0]), do: {[], r0}

    def request_uri([c | r0]) do
        {rest, r1} = request_uri(r0)
        {[c | rest], r1}
    end

    def http_version([?H, ?T, ?T, ?P, ?/, ?1, ?., ?1 | r0]) do
        {:v11, r0}
    end

    def http_version([?H, ?T, ?T, ?P, ?/, ?1, ?., ?0 | r0]) do
        {:v10, r0}
    end

    def headers([13, 10 | r0]), do: {[], r0}

    def headers(r0) do
        {header, r1} = header(r0)
        {rest, r2} = headers(r1)
        {[header | rest], r2}
    end

    def header([13, 10 | r0]), do: {[], r0}

    def header([c | r0]) do
        {rest, r1} = header(r0)
        {[c | rest], r1}
    end

    def message_body(r), do: {r, []}

    def ok(body) do
        "HTTP/1.1 200 OK\r\n\r\n #{body}"
    end

    def get(uri) do
        "GET #{uri} HTTP/1.1\r\n\r\n"
    end
end

defmodule Rudy do

    def init(port) do
        opt = [:list, active: false, reuseaddr: true]

        case :gen_tcp.listen(port, opt) do
            {:ok, listen} ->
                handler(listen)
                :gen_tcp.close(listen)
                :ok
            {:error, error} ->
                error
        end
    end

    def handler(listen) do
        case :gen_tcp.accept(listen) do
            {:ok, client} ->
                request(client)
                handler(listen)
            {:error, error} ->
            error
        end
    end

    def request(client) do
        recv = :gen_tcp.recv(client, 0)
        case recv do
            {:ok, str} ->
                #answer = HTTP.parse_request(str) 
                answer = HTTP.parse_request("#{str}")
                response = reply(answer)
                :gen_tcp.send(client, response)
            {:error, error} ->
                IO.puts("RUDY ERROR: #{error}")
        end
        :gen_tcp.close(client)
    end

    # def reply({{:get, uri, _}, _, _}) do
    #     HTTP.ok("Hello!")
    # end

    def reply({{:get, uri, _}, _, _}) do
        :timer.sleep(10)
        HTTP.ok("Hello!")
    end

    def start(port) do
        Process.register(spawn(fn -> init(port) end), :rudy)
    end

    def stop() do
        Process.exit(Process.whereis(:rudy), "Time to die!")
    end

end

defmodule Test do

    @number_requests 100

    def bench(host, port) do
        start = Time.utc_now()
        run(@number_requests, host, port)
        finish = Time.utc_now()
        diff = Time.diff(finish, start, :millisecond)
        IO.puts("Benchmark: #{@number_requests} requests in #{diff} ms")
    end

    defp run(0, _host, _port), do: :ok
    defp run(n, host, port) do
        request(host, port)
        run(n - 1, host, port)
    end

    defp request(host, port) do
        opt = [:list, active: false, reuseaddr: true]
        {:ok, server} = :gen_tcp.connect(host, port, opt)
        :gen_tcp.send(server, HTTP.get("foo"))
        {:ok, _reply} = :gen_tcp.recv(server, 0)
        :gen_tcp.close(server)
    end

end