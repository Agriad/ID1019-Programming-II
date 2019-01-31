defmodule Huffman do
    def sample do
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end
    # [t, h, e,  , q, u, i, c, k,  , b,]

    def text()  do
        'this is something that we should encode'
    end

    def new_text() do
        '

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lacus massa. Aenean pulvinar ligula libero, eu suscipit quam tempor pharetra. Proin porta velit id feugiat volutpat. Vestibulum sed libero sit amet orci fermentum congue non non augue. Morbi vel turpis at ligula faucibus dapibus id vel velit. Sed est elit, porttitor sit amet leo in, venenatis malesuada enim. Aenean magna tellus, rhoncus a ultrices id, commodo in libero. Nulla varius vitae nibh et porttitor. Duis id fermentum enim. Mauris placerat lacus nec mi pharetra, vel finibus purus elementum. Vestibulum semper sapien tortor, ut consequat lacus ultricies id. Sed scelerisque risus arcu, eget posuere velit commodo ac. Aliquam est metus, tincidunt nec est in, tempus maximus nisl. Nam tristique mollis lacus, a rutrum dui.

Maecenas posuere mi ut rhoncus placerat. Vivamus a porta risus. Vestibulum eu elit commodo, volutpat neque ac, mollis libero. Phasellus ex neque, viverra eu sapien aliquam, molestie varius velit. Proin laoreet, diam et maximus cursus, orci est tincidunt nunc, in viverra eros risus eu est. Suspendisse quam erat, mollis in magna et, consequat congue nisl. Suspendisse eu malesuada nibh, non pharetra est. Sed in libero quis dui dapibus venenatis ut ut tortor. Etiam bibendum condimentum lacus sed iaculis. Aliquam gravida eget ex sed vehicula. Curabitur malesuada laoreet lectus a convallis. Aliquam erat dolor, tristique quis sodales hendrerit, venenatis convallis nibh. Nulla nulla neque, mollis ac libero nec, pharetra pretium risus. Etiam id venenatis turpis. Mauris vel lacus ornare, pellentesque nunc id, porttitor felis. Fusce volutpat mollis ante at rutrum.

Morbi facilisis in libero in molestie. Curabitur congue augue in nibh mollis sagittis. Duis malesuada imperdiet lorem, sed viverra neque pharetra ut. Duis porta odio sed volutpat suscipit. Sed et iaculis ligula, luctus tristique nisi. Quisque sollicitudin nulla a ex varius hendrerit. Aliquam in felis ut erat eleifend rutrum at in dolor. Praesent rutrum erat sit amet vulputate ullamcorper. Suspendisse potenti. Morbi risus dui, fringilla non ex id, congue varius risus.

Quisque gravida egestas velit a interdum. Curabitur vel lorem vel magna rhoncus tincidunt nec vel elit. Duis id iaculis massa, ut iaculis magna. Curabitur neque est, auctor nec purus non, ullamcorper feugiat odio. Integer quis rhoncus odio, ac vulputate eros. Integer finibus molestie orci eget efficitur. Mauris aliquet ligula nec sem porta pretium. Donec nec nibh urna. In id auctor dui. Morbi non augue erat. Donec convallis lorem nulla, sed volutpat orci hendrerit in. Ut ligula libero, tempor at convallis vitae, tempus vitae nunc. Phasellus gravida sed velit at aliquet.

Etiam purus nisl, dignissim non dignissim ac, vulputate in eros. Integer volutpat tristique tortor bibendum dapibus. Vestibulum vel orci et justo efficitur tristique non non libero. Integer convallis, nibh vel ultricies vestibulum, ipsum sem elementum dolor, a dictum tortor est at ante. Vivamus quis libero quam. Morbi fringilla ipsum vel tellus volutpat, vel tempor lectus dignissim. Curabitur vel posuere velit, ut ornare quam. abcdefghijklmnopqrstuvxwz'
    end

    def new_text1() do
        '

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam aliquet, urna vel tempor porta, tellus massa vulputate leo, quis efficitur augue augue eu ex. Suspendisse a fermentum libero. Nunc congue tristique metus vel hendrerit. In eget lobortis sem. Ut volutpat lectus dui, nec finibus dui sagittis non. Quisque ut luctus arcu, eget placerat mi. Ut massa ex, pellentesque sed sem commodo, tempor aliquet felis. Sed id aliquam sem, eu posuere neque. Nulla tellus dui, pretium vel consectetur in, pretium in enim. Pellentesque at cursus velit, vel rutrum velit. Pellentesque et purus ut justo viverra mollis.

Nulla ornare porttitor aliquet. Nullam consectetur eu sapien rhoncus pretium. Fusce mollis quam cursus est venenatis posuere. Integer sit amet varius metus, at tincidunt urna. Mauris eros sem, malesuada a velit et, accumsan venenatis massa. Quisque venenatis leo a diam pharetra, vel iaculis dolor luctus. Praesent nec ex sed urna molestie congue sed vitae elit. In imperdiet laoreet finibus.

Praesent sit amet placerat est, at congue urna. Quisque cursus, lorem ut ultrices lacinia, nulla lorem sagittis eros, faucibus sollicitudin nibh odio a elit. Nam felis nisi, ullamcorper sed dictum eget, volutpat sit amet tortor. Vestibulum sed auctor massa. Aliquam nec arcu erat. Aenean viverra, nulla mollis sodales faucibus, nunc mauris pharetra sem, nec ullamcorper dolor velit a tortor. Nunc accumsan varius enim nec pretium. Nulla id rutrum sapien, eget varius mi. Nullam porttitor ornare enim ut maximus.

Suspendisse sit amet lectus purus. Cras elementum eleifend viverra. Nam suscipit, nibh eget dapibus vehicula, felis eros vehicula mauris, id commodo elit tortor id lorem. Curabitur fermentum quam id egestas ornare. Integer vulputate non velit id pellentesque. Cras sodales finibus dolor eu interdum. Suspendisse placerat neque non erat consectetur luctus.

Suspendisse ex dolor, consectetur et faucibus sed, volutpat ut nulla. Fusce dapibus enim enim, non ullamcorper orci blandit vitae. Nam porttitor, massa non pellentesque lacinia, urna urna pellentesque quam, ut vulputate massa ante vel urna. Nam tristique enim at tempor dapibus. Pellentesque gravida vel velit ac placerat. Aenean scelerisque egestas nunc, id suscipit metus ornare sed. Suspendisse mollis lobortis erat, sit amet varius dui tincidunt sit amet. Nam sit amet luctus enim. Vestibulum dapibus fermentum aliquet. Phasellus blandit urna aliquet, congue magna eu, elementum ipsum. Suspendisse ornare in urna vitae pellentesque.

Donec aliquam, felis id cursus facilisis, arcu neque vehicula neque, at consequat eros neque non turpis. Vestibulum commodo, mauris eu ullamcorper rhoncus, orci metus aliquam nisi, eget lacinia quam nisi eget sapien. Sed nec varius lectus. Cras scelerisque placerat ligula, at hendrerit tortor maximus et. Nullam consectetur mauris ut magna sollicitudin, at porttitor quam accumsan. In at urna sit amet nisi fermentum condimentum. Etiam hendrerit leo magna, eu cursus magna convallis quis. Vestibulum tempor risus libero, vel dapibus urna gravida non. Sed ac dapibus velit, ac semper lectus.

Curabitur a ante ex. Vivamus ut magna risus. Phasellus in ligula pulvinar ante lacinia semper nec at tellus. Donec non ullamcorper est. Nullam non nisi a enim imperdiet faucibus non eu enim. Donec ligula tortor, accumsan sed tellus quis, ultricies euismod mauris. Vivamus tempor ante sem, id laoreet dui interdum ut. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer tincidunt lectus felis, id suscipit erat volutpat quis. Cras eu facilisis nisi. Ut mollis varius fermentum. Donec magna felis, hendrerit sit amet ex non, volutpat sagittis quam. Ut gravida tempus magna. Duis sodales arcu vitae aliquam maximus. Praesent dolor nibh, egestas eget enim lacinia, tristique venenatis dui.

Nulla tristique neque urna, ut volutpat erat pharetra sit amet. Quisque convallis pretium sollicitudin. Suspendisse interdum magna a mi congue, at tincidunt nisi commodo. Suspendisse potenti. Morbi eget congue odio, eget fermentum massa. Suspendisse congue neque id ex pulvinar commodo. Nunc aliquet ligula ac urna facilisis tempor. Praesent porta massa aliquam tincidunt efficitur. Vestibulum vel nunc quis mi congue gravida. Nam posuere odio eu nisl posuere, ut maximus lectus aliquet.

Ut in ex fermentum velit pretium pellentesque. Proin mattis ex nec nibh interdum sodales. Pellentesque a ex a massa scelerisque iaculis. Vestibulum laoreet tincidunt nibh, vitae eleifend urna congue vel. Praesent feugiat, velit eget aliquet tempus, est nisl semper tortor, a facilisis est tellus vitae ligula. Nam dapibus dolor in odio suscipit aliquet. Sed nisl dolor, dapibus id eros a, laoreet laoreet dui. Nulla eu commodo nunc. In at urna odio. Duis vitae sagittis urna, ac commodo neque. Nulla ut sagittis orci. Donec eu placerat nisi. Suspendisse bibendum pharetra eros in varius. Fusce justo metus, dapibus ut tempor eu, laoreet quis risus. Proin iaculis nisi vel diam fringilla, sit amet sagittis felis aliquam.

Quisque et eros ligula. Ut feugiat lacinia orci, non faucibus libero dapibus at. Donec tempus arcu sed nunc aliquet, nec tincidunt eros iaculis. Vestibulum rhoncus, ipsum vitae rhoncus elementum, sem quam aliquam nulla, sit amet venenatis nisl ex a augue. Morbi pharetra maximus efficitur. Pellentesque tempor velit eu sodales cursus. Aliquam neque ligula, pretium in arcu aliquam, cursus sagittis arcu. Maecenas pharetra condimentum eros, sed mattis urna venenatis pulvinar. Sed ultricies, leo in sollicitudin bibendum, ante mauris gravida enim, non tempus erat urna sed est. Aliquam sit amet ipsum lacinia, finibus metus quis, condimentum mi. Nulla dignissim ipsum turpis, eget sollicitudin ipsum hendrerit vel. Ut vestibulum lacus fermentum blandit egestas. Duis metus est, sodales ut suscipit cursus, varius ornare urna. abcdefghijklmnopqrstuvxwz'
    end

    def new_text2() do
        '

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed cursus purus non congue commodo. Morbi dictum mauris in hendrerit congue. Vestibulum convallis odio vulputate arcu tempus, ac iaculis nisl finibus. Proin vel diam interdum, posuere nisl vitae, porta massa. Sed vestibulum volutpat sapien. Sed ultricies blandit nulla vel consectetur. Phasellus laoreet nisl eu pharetra fermentum. Nam ac ante neque. Praesent blandit mi quam, eu condimentum nibh iaculis sit amet. Nullam pellentesque, mi non gravida pulvinar, magna risus mattis arcu, quis lobortis erat neque quis metus. Donec quis massa a massa posuere ullamcorper sit amet a nulla. In hac habitasse platea dictumst.

Proin tempor quis neque sed bibendum. Nulla placerat maximus ullamcorper. Praesent pharetra, dui nec suscipit fringilla, augue augue sagittis lorem, in cursus massa quam non erat. Etiam porta, sapien et feugiat laoreet, elit orci posuere ligula, vel aliquam sem lectus at lorem. Vivamus at rutrum sapien. Maecenas ac convallis turpis. Nulla vitae ex ac lacus placerat elementum non in velit. Nullam pretium, leo in sollicitudin tristique, urna ante viverra mauris, non egestas purus diam vitae ipsum. Quisque eget egestas quam. Proin eleifend, magna non hendrerit auctor, risus mi eleifend lectus, et facilisis nibh sapien at velit. Suspendisse tempus quis justo in condimentum.

Duis lacinia ultrices sapien et posuere. Ut hendrerit tempor mauris eu fermentum. Quisque eros justo, euismod ac facilisis vitae, feugiat eu libero. Proin porta, mi eu finibus dictum, ex diam gravida metus, vitae consectetur urna nisi in purus. Mauris et massa sed sapien sodales porta ut sit amet felis. Phasellus convallis odio eu aliquam iaculis. Nulla est sapien, interdum vel massa nec, ornare eleifend orci. Fusce nisl ipsum, tincidunt sit amet tristique sollicitudin, pellentesque id justo. Curabitur lectus justo, congue nec dui a, suscipit facilisis purus. Proin malesuada, mi sed pharetra maximus, justo justo gravida sem, eget venenatis massa elit ut eros. Aliquam eleifend dapibus velit non consectetur. Mauris accumsan bibendum purus, et lacinia neque consectetur sit amet. Donec consequat sem a sagittis fringilla. Aliquam bibendum leo purus, nec vulputate ex pretium vitae. Mauris consectetur, ex ac tempus aliquet, erat ex aliquam odio, in dapibus dolor magna nec enim. Proin dapibus commodo dolor eu finibus.

Nulla non vehicula purus, ut maximus urna. Mauris blandit congue dignissim. Quisque imperdiet nisi vel orci placerat faucibus. Proin vel lacus et enim venenatis pellentesque. Fusce convallis sollicitudin rhoncus. Morbi et tellus varius, iaculis massa ut, sodales diam. Aliquam consectetur ut ipsum id faucibus. Nam et laoreet purus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean id libero vulputate, lacinia neque sit amet, efficitur augue. Morbi in tortor turpis. Aliquam tempus consequat eros, in porttitor dolor volutpat at. Nam odio eros, eleifend a cursus quis, sodales at sem. Aliquam sit amet ullamcorper risus. Morbi placerat pretium nunc. Sed a ultrices justo, non aliquam orci.

Pellentesque laoreet lacus non nunc blandit sagittis. Nam nec purus magna. Nunc nec dapibus diam. Cras accumsan, augue non tristique viverra, tellus erat eleifend sapien, cursus elementum dui massa nec velit. Sed efficitur tempus purus, a gravida ante condimentum sed. In euismod quis mauris eu egestas. Mauris quam purus, elementum eget pharetra ac, tincidunt quis odio. Vestibulum vulputate blandit efficitur.

Morbi gravida mauris vel ligula facilisis consequat quis bibendum sem. Praesent vehicula convallis velit, sed vehicula odio vulputate vitae. In dolor tellus, efficitur sit amet ante sit amet, elementum maximus eros. Morbi odio est, pretium vitae mattis nec, aliquam eget leo. Duis quis pretium velit. Integer mollis dolor finibus, sollicitudin nibh at, pretium ante. Cras et consectetur tortor. Cras placerat sapien at commodo facilisis. Vivamus pretium mauris id ipsum blandit tempus. Suspendisse potenti.

Vestibulum sollicitudin posuere aliquam. Fusce vel mi urna. Pellentesque egestas maximus nisi, a fringilla libero congue eu. Aliquam a massa suscipit, blandit tellus quis, ultricies nunc. Pellentesque pharetra, enim ut dictum varius, urna augue maximus sem, ac consequat purus neque non lorem. Suspendisse tincidunt, tortor vel porta placerat, quam mauris tincidunt diam, vel faucibus quam tortor non arcu. Integer vel rhoncus elit.

Aenean sed magna a lectus volutpat vestibulum. Ut commodo metus eu sapien sodales, nec vestibulum massa consequat. Aenean id ipsum dui. Sed a laoreet felis. Mauris sed metus tempus, ullamcorper nisl sit amet, convallis libero. Duis pulvinar dapibus bibendum. Praesent nec aliquam sapien. Sed laoreet aliquam scelerisque. Maecenas nisl libero, semper vel turpis eu, tempus mattis nisl. Nam efficitur augue id velit fermentum ornare. Maecenas condimentum felis at feugiat auctor. Morbi est lectus, molestie non viverra ac, lacinia volutpat velit. Mauris a dignissim risus. Vestibulum ac purus interdum, commodo lacus varius, aliquam lectus.

Phasellus vel metus finibus, fringilla libero ut, ornare orci. Pellentesque interdum sapien nec felis hendrerit, at facilisis justo elementum. Morbi quis orci in metus viverra hendrerit eu eget augue. Cras tincidunt vestibulum ligula at condimentum. Cras ultrices eros orci, et laoreet arcu pretium et. Praesent egestas sodales nulla nec fermentum. In hac habitasse platea dictumst. Nullam rutrum at ante eu varius. Aliquam mauris odio, pretium sit amet nibh quis, semper gravida tellus.

Donec ultrices nisi sed risus aliquam, vitae maximus turpis maximus. Pellentesque vehicula suscipit libero, at bibendum magna elementum eu. Donec egestas augue nec risus euismod finibus. Cras porta iaculis ipsum. Praesent semper, sem vitae hendrerit condimentum, leo lectus ultricies magna, ut fermentum velit ipsum sed massa. Duis consectetur purus nunc, ac tincidunt dui commodo nec. Donec egestas turpis est, sit amet sagittis augue fringilla sed. Nam ut mattis diam, eget varius tortor. Quisque mattis elementum sem, molestie ultricies neque blandit et.

Nam efficitur at nibh feugiat eleifend. Sed eleifend vestibulum leo, sit amet vulputate tellus sollicitudin eu. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis id nisl vitae orci sollicitudin tincidunt quis ac libero. Maecenas ex ipsum, consectetur consectetur mattis ac, eleifend mattis ex. Etiam scelerisque eget dolor vitae aliquam. Quisque facilisis scelerisque dignissim. Donec suscipit vulputate vestibulum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas scelerisque sem eu ornare tempus. Vivamus bibendum sit amet augue sit amet porta. Donec ut purus elit. Integer auctor risus magna, a maximus metus sodales eget.

Sed suscipit sem id tortor condimentum, sit amet elementum urna consectetur. Vivamus at ligula turpis. Pellentesque vehicula, diam ac pretium sodales, augue arcu tempus leo, tincidunt volutpat urna elit sed nulla. Vestibulum posuere a lectus vitae accumsan. Cras ornare rutrum ligula non porta. Nunc sit amet libero vitae justo tincidunt cursus. Sed euismod vehicula augue eget feugiat. Ut viverra enim non urna malesuada, in feugiat lorem tincidunt. Quisque sed mi eu lacus tincidunt ornare feugiat et libero. Donec ultricies in ipsum a placerat. Integer mauris neque, commodo vitae blandit sed, molestie ac odio. Nunc tempor mollis tortor rutrum consequat.

Vivamus fermentum nulla at tempus lobortis. Curabitur vitae viverra nulla. Proin eleifend sem nec sapien elementum egestas. Cras nunc nulla, hendrerit in magna sed, semper fringilla ipsum. Quisque consectetur euismod semper. Nulla at tristique sapien, venenatis luctus massa. Sed facilisis dui non est rhoncus, eget consequat nisi laoreet. Cras ut mauris dignissim, aliquet odio posuere, tempor turpis. Aliquam congue lacus eget imperdiet ultricies. Nam posuere, diam ut imperdiet malesuada, eros est auctor lorem, eget scelerisque neque ipsum nec dui. Integer placerat placerat ullamcorper. Maecenas vestibulum nisi ipsum, eget consequat elit placerat nec. Aenean posuere leo accumsan, tincidunt urna at, efficitur neque.

Aenean euismod ipsum ac mauris dictum, id rhoncus velit condimentum. Proin sed turpis pellentesque, cursus lorem id, condimentum nulla. Donec gravida massa id erat pellentesque, scelerisque pretium nulla fringilla. In facilisis, tellus ut cursus porta, urna leo porttitor dui, ac efficitur ante massa et nulla. Aenean cursus vel felis a tempor. Suspendisse potenti. Integer sollicitudin ac quam maximus facilisis. Phasellus tempus felis elit, non fermentum turpis varius ac. Vestibulum sit amet massa at ante placerat imperdiet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis nunc fringilla turpis bibendum tincidunt. Etiam molestie maximus magna. Curabitur ut finibus tellus.

Integer elit eros, pellentesque nec diam eu, auctor vestibulum neque. Duis ullamcorper eros a nulla elementum dapibus. Cras consectetur interdum orci vitae pretium. Etiam imperdiet tellus erat, at gravida sapien viverra ullamcorper. Phasellus dolor diam, laoreet ac facilisis sit amet, facilisis sit amet diam. Aenean dapibus dignissim rutrum. Vestibulum vel orci quis odio imperdiet hendrerit non vitae nibh. Donec eget neque magna. Etiam mollis lorem elit, vel hendrerit ex ultrices sed. Etiam velit urna, viverra eu vehicula vitae, fermentum at mauris. Sed viverra vestibulum lobortis. Maecenas pulvinar congue ante id consequat. Fusce ac sagittis mi, iaculis elementum sapien. abcdefghijklmnopqrstuvxwz'
    end

    # from: https://stackoverflow.com/questions/29668635/how-can-we-easily-time-function-calls-in-elixir
    def measure(function) do
        function
        |> :timer.tc
        |> elem(0)
        |> Kernel./(1_000_000)
    end

    def test1() do
        sample = new_text()
        # sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = new_text()
        seq = encode(text, encode)
        decode(seq, decode)
    end

    def test2() do
        sample = new_text1()
        # sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = new_text1()
        seq = encode(text, encode)
        decode(seq, decode)
    end

    def test3() do
        sample = new_text2()
        # sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = new_text2()
        seq = encode(text, encode)
        decode(seq, decode)
    end

    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
    end

    def tree(sample) do
        freq = freq(sample)
        huffman(freq)
    end

    def encode_table(tree) do
        encode_table_maker(tree)
    end

    def decode_table(tree) do
        encode_table_maker(tree)
    end

    # Huffman.encode(Huffman.sample, Huffman.encode_table(Huffman.tree(Huffman.sample)))
    def encode(text, table) do
        encoder(text, table, [])
    end

    # Huffman.decode(Huffman.encode(Huffman.sample, Huffman.encode_table(Huffman.tree(Huffman.sample))),
    # Huffman.encode_table(Huffman.tree(Huffman.sample)))
    def decode(seq, tree) do
        decoder(seq, tree, [], [])
    end

    @doc """
    Takes in a text and returns a list of tuples that contains the frequency of the characters.
    """
    def freq(sample) do
        freq(sample, [])
    end
    def freq([], freq) do
        freq
    end
    def freq([char | rest], freq) do
        # freq ++ check(char, freq)
        # IO.puts "freq3"
        # freq(rest, freq)
        # freq(rest, freq ++ check(char, freq))
        freq(rest, check(char, freq))
    end

    @doc """
    takes in a character and checks with the list if it exist. If it does not exist than create a new entry,
    else updates the entry
    """
    def check(char, []) do # issue
        [{char, 1}]
    end
    def check(char, list) do
        [h1 | t1] = list
        {h2, t2} = h1
        cond do
            char === h2 -> [{h2, t2 + 1} | t1]
            true -> [h1] ++ check(char, t1)
        end
    end
    # [{a, 5}, {b, 10}, ...]

    @doc """
    Takes in a list of tuples of frequency counters and returns a sorted binary list in tuple form
    {a, b}, a = {a, b}, b = int
    """
    def huffman([a | []]) do
        a
    end
    def huffman(freq) do
        min = minimum(freq)
        freq1 = remove(freq, min)
        # {min, freq1}
        min1 = minimum(freq1)
        freq2 = remove(freq1, min1)
        {_, v1} = min
        {_, v2} = min1
        node = {{min, min1}, v1 + v2}
        # node = {min1, min2, v1 + v2}
        freq3 = [node] ++ freq2
        huffman(freq3)
    end
    # {{a, 5}, l} 
    # l = {{b, 3}, {d, 1}}

    @doc """
    Takes in a frequency list of tuples and finds the minimum occurance tuple and returns it.
    """
    def minimum(freq) do
        [h | t] = freq
        minimum(freq, h)
    end
    def minimum([], min) do
        min
    end
    def minimum(freq, min) do
        {h , t} = min
        [h2 | t2] = freq
        {h3 , t3} = h2
        cond do
            t <= t3 -> minimum(t2, min)
            t > t3 -> minimum(t2, h2)
        end
    end

    @doc """
    Remove the input from the list of occurances
    """
    def remove(freq, element) do
        remove(freq, element, [])
        # [h | t] = freq
        # if h === element do
        #     remove([], [], t)
        # else
        #     remove(t, element, [])
        # end
    end
    def remove([], [], finished) do
        finished
    end
    def remove(freq, element, finished) do
        [h | t] = freq
        if h === element do
            t ++ finished
        else
            remove(t, element, [h] ++ finished)
        end
    end

    @doc """
    Finds the characters / integers in the tree and determines the code it produces
    left is 0 right is 1
    """
    # can optimize by making code constant and reverse in the end or look from leaf to root
    def encode_table_maker(tree) do
        {{left, right}, value} = tree
        list = encode_table_maker(left, [0], [])
        encode_table_maker(right, [1], list)
    end
    def encode_table_maker({{left, right}, value}, code, list) do
        new_list = encode_table_maker(left, code ++ [0], list)
        encode_table_maker(right, code ++ [1], new_list)
    end
    def encode_table_maker({element, value}, code, []) do
        [{element, code}]
    end
    def encode_table_maker({element, value}, code, list) do
        # list ++ [{element, code}]
        [{element, code}] ++ list
    end

    @doc """
    Uses the encode table to encode a message
    returns a list of the encoded message in binary
    """
    def encoder([], table, message) do
        # Enum.reverse(message)
        message    
    end
    def encoder(text, table, message) do
        [head | tail] = text
        code = search_table(head, table)
        # encoder(tail, table, code ++ message)
        encoder(tail, table, message ++ code)
    end

    @doc """
    Searches a list for the right element to find the correct code to encode it with
    """
    def search_table(element, []) do
        [nil]
    end
    def search_table(element, table) do
        [head | tail] = table
        {key, code} = head
        cond do
            element === key -> code
            true -> search_table(element, tail)
        end
    end

    @doc """
    Looks at the list of binary code and decodes it from the tree
    """
    def decoder([], table, check, message) do
        Enum.reverse(message)
        # message
    end
    def decoder(encoded, table, check, message) do
        [head | tail] = encoded
        new_check = check ++ [head]
        decode_answer = decode_checker(new_check, table)
        case decode_answer do
            [nil] -> decoder(tail, table, new_check, message)
            _ -> decoder(tail, table, [], [decode_answer] ++ message)
        end
    end

    @doc """
    Checks a specific code and checks if it exist in the coding table. 
    """
    def decode_checker(code, []) do
        [nil]
    end
    def decode_checker(code, table) do
        [head | tail] = table
        {element, element_code} = head
        cond do
            code === element_code -> element
            true -> decode_checker(code, tail)
        end
    end
    # f = 0,0,0,0,0
    # t = 1,1,0,0
end