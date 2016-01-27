# ASCIIToons

make your projects more awesomer with customizable ascii art

## Installation

```
gem install ascii_toons
```

## Usage

```rb
require 'ascii_toons'
=> true
ASCIIToons::Gandalf.say 'You shall not pass!'

                           ,---.
                          /    |
                         /     |
 You shall not pass!    /      |
                       /       |
          \       ___,'        |
                <  -'          :
                 `-.__..--'``-,_\_
                    |o/ <o>` :,.)_`>
                    :/ `     ||/)
                    (_.).__,-` |\
                    /( `.``   `| :
                    \'`-.)  `  ; ;
                    | `       /-<
                    |     `  /   `.
    ,-_-..____     /|  `    :__..-'\
   /,'-.__\\  ``-./ :`      ;       \
   `\ `\  `\\  \ :  (   `  /  ,   `. \
     \` \   \\   |  | `   :  :     .\ \
      \ `\_  ))  :  ;     |  |      ): :
     (`-.-'\ ||  |\ \   ` ;  ;       | |
      \-_   `;;._   ( `  /  /_       | |
       `-.-.// ,'`-._\__/_,'         ; |
          \:: :     /     `     ,   /  |
           || |    (        ,' /   /   |
           ||                ,'   /    |
```

Spice up your guard clauses for your rake tasks stopping people from dropping prod:

```rb
task :drop_database do
  if Rails.env.production?
    ASCIIToons::Gandalf.say 'You shall not pass!'
    raise
  end
  # ...
end
```

Or if you want to get real sassy (for the love of god, don't commit this):

```rb
require 'ascii_toons'

module KernelPatch
  AGENT = ASCIIToons::CatInTheHat
  def raise(*args)
    case args.size
    when 0
      e = $! || RuntimeError
      AGENT.say e
      super(e, '', caller)
    when 1
      if args[0].is_a?(Class) && args[0] < Exception
        e = args[0]
        msg = e.to_s
      else
        e = RuntimeError
        msg = args[0]
      end
      AGENT.say "#{e.name}: #{msg}"
      super(e, msg, caller)
    when 2
      e, msg = *args
      AGENT.say "#{e}: #{msg}"
      super(e, msg, caller)
    when 3
      e, msg, _ = *args
      AGENT.say "#{e}: #{msg}"
      super(*args)
    end
  end
end

Object.prepend KernelPatch

raise 'oh snap'
=>
        .;''-.
      .' |    `._
     /`  ;       `'.
   .'     \         \
  ,'\|    `|         |
  | -'_     \ `'.__,J
 ;'   `.     `'.__.'
 |      `"-.___ ,'
 '-,           /
 |.-`-.______-|
 }      __.--'L
 ;   _,-  _.-"`\         ___
 `7-;"   '  _,,--._  ,-'`__ `.
  |/      ,'-     .7'.-"--.7 |        _.-'
  ;     ,'      .' .'  .-. \/       .'       RuntimeError: oh snap
   ;   /       / .'.-     ` |__   .'
    \ |      .' /  |    \_)-   `'/   _.-'``    /
     _,.--../ .'     \_) '`_      \'`
   '`f-'``'.`\;;'    ''`  '-`      |
      \`.__. ;;;,   )              /
       `-._,|;;;,, /\            ,'
        / /<_;;;;'   `-._    _,-'
       | '- /;;;;;,      `t'` \.
       `'-'`_.|,';;;,      '._/|
       ,_.-'  \ |;;;;;    `-._/
             / `;\ |;;;,  `"
           .'     `'`\;;, /
          '           ;;;'|
              .--.    ;.:`\    _.--,
             |    `'./;' _ '_.'     |
              \_     `"7f `)       /
              |`   _.-'`t-'`"-.,__.'
              `'-'`/;;  | |   \
                  ;;;  ,' |    `
                      /   '
RuntimeError: oh snap
	from (irb):35
	from /Users/Bodah/.rbenv/versions/2.1.3/bin/irb:11:in `<main>'
```
