# thingy-allmodules-sync - commandline wizard to create the appropriate allmodules files

# Background
For my current development process I find it handy to have a `allmodules.coffee` or `allstyles.styl` file by in `sources/source/allmodules`.
My current developtment style is to develop on my things as [thingies](https://hackmd.io/CWQerPTRR0CrRd-gpKKd-Q).

This way I could reach all of the thingymodules at one point and automate away the task to add the modules there whenever modules added or removed.
This is the automation tool for creating these files.

It will scan through all modules available in `sources/source/` of the specified thingy.
For each module being a module (identified by having a name whichs ends with "module") we will add an import statement
to the `allmodules.coffee` and `allstyles.styl` files. Those files may be found at `sources/source/allmodules/`.

# Usage
Installation
------------

Current git version
``` sh
$ npm install git+https://github.com/JhonnyJason/thingy-allmodules-sync-output.git
```
Npm Registry
``` sh
$ npm install thingy-allmodules-sync
```

ClI
-----

```sh
    Usage
        $ thingy-allmodules-sync <arg1>

    Options
        optional:
            arg1, --thingy-path <path/to/thingy>, -p <path/to/thingy> [default: ./ ]
                path to the root of the thingy. Usually it is cwd. Use it if you call this script from somewhere else.
    TO NOTE:
        The flags will overwrite the flagless argument.
    Examples
        $ thingy-allmodules-sync 
        ...
```

The `thingyPath` is optional and will be the current working directory when being omitted.
The generation will fail when we donot have a `sources/source/allmodules` with this `thingyPath`.

 
# Further steps
Are there any? 

- fix bugs
- ...

All sorts of inputs are welcome, thanks!

---

# License

## The Unlicense JhonnyJason style

- Information has no ownership.
- Information only has memory to reside in and relations to be meaningful.
- Information cannot be stolen. Only shared or destroyed.

And you wish it has been shared before it is destroyed.

The one claiming copyright or intellectual property either is really evil or probably has some insecurity issues which makes him blind to the fact that he also just connected information which was freely available to him.

The value is not in him who "created" the information the value is what is being done with the information.
So the restriction and friction of the informations' usage is exclusively reducing value overall.

The only preceived "value" gained due to restriction is actually very similar to the concept of blackmail (power gradient, control and dependency).

The real problems to solve are all in the "reward/credit" system and not the information distribution. Too much value is wasted because of not solving the right problem.

I can only contribute in that way - none of the information is "mine" everything I "learned" I actually also copied.
I only connect things to have something I feel is missing and share what I consider useful. So please use it without any second thought and please also share whatever could be useful for others. 

I also could give credits to all my sources - instead I use the freedom and moment of creativity which lives therein to declare my opinion on the situation. 

*Unity through Intelligence.*

We cannot subordinate us to the suboptimal dynamic we are spawned in, just because power is actually driving all things around us.
In the end a distributed network of intelligence where all information is transparently shared in the way that everyone has direct access to what he needs right now is more powerful than any brute power lever.

The same for our programs as for us.

It also is peaceful, helpful, friendly - decent. How it should be, because it's the most optimal solution for us human beings to learn, to connect to develop and evolve - not being excluded, let hanging and destroy.

If we really manage to build an real AI which is far superior to us it will unify with this network of intelligence.
We never have to fear superior intelligence, because it's just the better engine connecting information to be most understandable/usable for the other part of the intelligence network.

The only thing to fear is a disconnected unit without a sufficient network of intelligence on its own, filled with fear, hate or hunger while being very powerful. That unit needs to learn and connect to develop and evolve then.

We can always just give information and hints :-) The unit needs to learn by and connect itself.

Have a nice day! :D