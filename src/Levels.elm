module Levels exposing (levels)
import Array

type alias Level = {
    name : String
    , aka : List String
    , card : String
    , info : List String
    , contents : List String
    }

levels = Array.fromList [
    zero
    , one
    , two
    , three
    , four
    , five
    , six
    , n
    , omega
    , omega1
    , omega2
    , omega5
    , omega6
    , omegao
    , omegas
    , omegaomega
    , v
    ]

set : List String -> String
set x = "\\{" ++ (String.join "," x) ++"\\}"
emptyset = "\\{\\}"

zero = {
        name = "V_0"
        , aka = ["0", "\\emptyset"]
        , card = "0"
        , info = ["Welcome! This is an app to explore the Von Neumann Universe, \\(V\\), the universe that encompasses most of math.", "It is defined by transfinite recursion, and the empty set, \\(\\emptyset\\), is the base case.", "Use the up down arrows keys to check out some more stages."]
        , contents = []
    }
one = {
        name = "V_1"
        , aka = ["1", "\\wp(V_0)"]
        , card = "1"
        , info = ["We get the next stages of the Von Neuman Universe by taking the powerset of the previous stage, so \\(V_1 = \\wp (V_0)\\).", "Since the emptyset is the only subset of the emptyset, \\(V_1\\) is the singleton of the emptyset.", "These things are gonna grow quickly so I'm going to represent sets as their corresponding ordinal when possible so \\(\\emptyset = 0 \\)."]
        , contents = ["0"]
    }

two = {
        name = "V_2"
        , aka = ["2", "\\wp(V_1)"]
        , card = "2"
        , info = ["Continue by taking the powerset of the previous stage.", "So far, \\(V_i = i\\) if we think of \\(i\\) as a Von Neumann ordinal, but this trend will soon end."]
        , contents = ["0", "1"]
    }

three = {
        name = "V_3"
        , aka = ["\\wp(V_2)"]
        , card = "4"
        , info = ["One consequence of the fact that \\(V_n = \\wp(V_{n-1})\\), is that \\(|V_n| = 2^{|V_{n-1}|}\\)."]
        , contents = ["0", "1", "2", set ["1"]]
    }

four = {
        name = "V_4"
        , aka = ["\\wp(V_3)"]
        , card = "16"
        , info = ["Finally some more sets!"]
        , contents = ["0", "1", "2", "3", set ["1"], set ["2"]
            , set [set ["1"]], set ["0", "2"], set ["0", set ["1"]]
            ,set ["1", "2"], set ["1", set["1"]], set ["2", set ["1"]]
            , set ["1", "2", set["1"]]
            , set ["0", "2", set["1"]]
            , set ["0", "1", set["1"]]
            , "V_3"
            ]
    }
five = {
        name = "V_5"
        , aka = ["\\wp(V_4)"]
        , card = "2^{16} = 65536"
        , info = ["Woowww that's a lot of sets. So many that I'm not gonna put them all here..", "But at this stage we can start to see some cool patterns emerging. An obvious one is that \\(V_{n-1} \\in V_n\\), as every set is a subset of itself. A less obvious one is \\(V_{n-1} \\subseteq V_n\\) (why?). Actually something even cooler holds..."]
        , contents = ["0", "1", "2", "3", "4",  set ["1"], set ["2"]
            , "V_4", "..."
            ]
    }

six = {
        name = "V_6"
        , aka = ["\\wp(V_5)"]
        , card = "2^{65536}"
        , info = ["In just 6 steps, we have made a set with \\(2^{65536}\\) elements.", "To put that into perspective, even a super sharp 4k screen has less than \\(2^{30}\\) pixels so it's impossible to display each set on the screen at once.", 
        "Actually, the number of atoms in the universe is less than \\(2^{300}\\), so it's safe to say that \\(V_6\\) is significantly bigger than the physical universe."]
        , contents = ["0", "1", "2", "3", "4", "5", set ["1"], set ["2"]
            , "V_4", "V_5", "..."
            ]
    }

n = {
        name = "V_n"
        , aka = ["\\wp(V_{n-1})"]
        , card = "\\text{Some huge (finite) number too large to comprehend}"
        , info = ["We saw that \\(V_6\\) was already much bigger than the universe yet it didn't even contain the number 6! So it's clear that we can't stop at 6 if we want the Von Neumann Universe to host all of mathematics!", "So we continue to take powersets for each \\(n\\). Note that no \\(V_n\\) will contain all the natural numbers becuase it won't contain the number \\(n\\)."]
        , contents = ["0", "1", "2", "...", "n-1", "5", set ["1"],"...", set ["n-2"]
            , "V_4", "V_5", "...", "V_{n-1}", "..."
            ]
    }

omega = {
        name = "V_{\\omega}"
        , aka = []
        , card = "\\omega = \\aleph_0"
        , info = ["We get \\(V_\\omega\\) by the first limit case in our transfinite recursion. It is defined as \\( \\bigcup_{i < \\omega} V_i \\). \\(V_\\omega\\) is also the set of heredetarily finite sets, meaning it contains any set whose elements are also heredetarily finite.", "It's the first stage that is infinite, even though it's just countable (it's the countable union of a bunch of finite sets). Although \\(V_\\omega\\) is infinite, every set in \\(V_\\omega\\) is still finite, so we can't stop just yet."]
        , contents = ["\\text{Any } n", "\\text{Any } V_{n}", "\\text{Any hereditarily finite set}", "..."]
    }

omega1 = {
        name = "V_{\\omega+1}"
        , aka = []
        , card = "2^{\\aleph_0} = |\\mathbb{R}| \\stackrel{?}{=} \\aleph_1"
        , info = ["\\(V_{\\omega + 1}\\) is again the powerset of \\(V_\\omega\\). Here we start to create some mathematical structures such as \\(\\mathbb{N}\\). We get this because every \\(n \\in V_\\omega\\).", "The cardinality of \\(V_{\\omega + 1} = 2^{|\\mathbb{N}|}\\), which is uncountable by Cantor's theorem, and happens to have the same as the cardinality of \\(\\mathbb{R}\\). This is or is not equal to \\(\\aleph_1\\) depending on whether you take the continuum hypothesis to be true or false (either statement is consistent with ZFC thanks to Godel and Cohen!)." ]
        , contents = ["\\omega = \\mathbb{N}", "\\text{Any subset of } \\mathbb{N}", 
        "\\text{Any integer}", "\\text{Any } f: \\mathbb{N} \\to \\mathbb{N}", "..."
        ]
    }
    
omega2 = {
        name = "V_{\\omega+2}"
        , aka = []
        , card = "2^{|\\mathbb{R}|}"
        , info = ["An integer is an equivalence class on ordered pairs of natural numbers. Each ordered pair is in \\(V_\\omega\\), so the equivalence class is a subset of \\(V_\\omega\\) and hence in \\(V_{\\omega+1}\\). Thus \\(\\mathbb{Z} \\subseteq V_{\\omega+1}\\), and so \\(\\mathbb{Z} \\in V_{\\omega +2}\\)", "The cooler property that holds for each \\(V_\\alpha\\) is known as transitivity: \\[x \\in V_\\alpha \\implies x \\subseteq V_\\alpha.\\]"  ]
        , contents = ["\\mathbb{N}", "\\mathbb{Z}", 
        "\\text{All natural numbers and integers}", "..."
        ]
    }

omega5 = {
        name = "V_{\\omega+5}"
        , aka = []
        , card = "\\text{Really big}"
        , info = ["A rational number is an equivalence class of ordered pairs of integers so we can find \\(\\mathbb{Q}\\) somewhere in \\(V_{\\omega +5}\\)", "Note that as \\(V_\\alpha \\subseteq V_{\\alpha +1}\\), we are not losing any sets at any stage of the hierarchy, i.e. \\(V_{\\omega+5}\\) still contains all the hereditarily finite sets, and everything in \\(V_{\\omega + 4}\\)"]
        , contents = ["\\mathbb{Q}", "\\mathbb{Z}", 
        "\\text{All natural numbers, integers, and rationals}"
        ,"..."
        ]
    }

omega6 = {
        name = "V_{\\omega+6}"
        , aka = []
        , card = "\\text{Really reallly big}"
        , info = ["Each \\(r \\in \\mathbb{R} \\) is a subset of \\(\\mathbb{Q}\\), so \\(\\mathbb{R}\\) can be found in \\(V_{\\omega+6}\\)"]
        , contents = [
            "\\mathbb{R}"
            ,"\\mathbb{Q}"
            ,"\\mathbb{N}"
            ,"\\text{hereditarily finite sets}"
            ,"..."
            ]
    }
    -- 
omegan = {
        name = "V_{\\omega+n}"
        , aka = []
        , card = "\\text{Huge}"
        , info = ["We can continue moving up the hierarcy with the powerset operation, and get more and more mathematical structures"]
        , contents = [
            "\\text{So many things}"
            ,"..."
            ]
    }
omegao = {
        name = "V_{\\omega+\\omega}"
        , aka = []
        , card = "\\text{Ridiculous}"
        , info = ["This is the next limit case so \\(V_{\\omega+\\omega} = \\bigcup_{\\alpha < \\omega + \\omega} V_\\alpha\\). Wikipedia calls this set the universe of ordinary mathematics", "This is actually a model for ZFC without the axiom of replacement (axiom of replacement implies the existence of \\(\\omega + \\omega\\))"]
        , contents = [
            "\\text{``Ordinary Mathematics\"}"
            ,"..."
            ]
    }
omegas = {
        name = "V_{\\omega^2}"
        , aka = []
        , card = "\\text{Gigantic}"
        , info = ["Don't know much about this one"]
        , contents = [
            "\\text{``Extreme Mathematics???\"}"
            ,"..."
            ]
    }

omegaomega = {
        name = "V_{\\omega^{\\omega}}"
        , aka = []
        , card = "\\text{Lost count a long time ago..}"
        , info = ["Don't know much about this one"]
        , contents = [
            "\\text{Even more stuff}"
            ,"..."
            ]
    }

v = {
        name = "V"
        , aka = []
        , card = "??"
        , info = ["Finally, \\(V = \\bigcup_{\\alpha \\in \\textbf{Ord}} V_\\alpha\\)", "It is the union of all the stages for each ordinal. Note that \\(V\\) is not a set but rather a class. If it were a set, there would be problems as \\(V\\) is a model for ZFC, but this would contradict the second incompleteness theorem.", "Take a minute to think about the size of this thing. \\(V_6\\) was already much larger our universe. We then had infinitely many stages after that. Wild."]
        , contents = [
            "\\text{Everything?!}"
            ]
    }