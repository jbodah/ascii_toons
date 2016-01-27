# ASCIIToons

make your projects more awesomer with customizable ascii art

## Installation

```
gem install ascii_toons
```

## Usage

```rb
ASCIIToons::Gandalf.say 'You shall not pass!'
ASCIIToons::Alien.say 'hello world'
ASCIIToons::CatInTheHat.say 'you done broke things'

module KernelPatch
  AGENT = ASCIIToons::CatInTheHat
  def raise(*args)
    case args.size
    when 0
      e = $! || RuntimeError
      AGENT.say e
      super(e, '', caller)
    when 1
      if args[0] < Exception
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
```
