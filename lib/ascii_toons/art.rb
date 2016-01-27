module ASCIIToons
  class Art
    attr_accessor :message_sentinel, :message_callout_symbol, :message_callout_sentinel, :alignment

    def initialize(template)
      @alignment = :center
      parse File.read(template)
    end

    def print(message = nil)
      if message
        # Create a clean slate for the body buffer, we will write over it later
        body_buffer = @body.tr(message_sentinel, ' ')
        body_buffer = body_buffer.tr(message_callout_sentinel, message_callout_symbol) if message_callout_sentinel
        body_buffer = body_buffer.each_line.to_a

        line_idx_stack = @body.each_line.each_with_index.select { |line, idx| line[/#{Regexp.escape(message_sentinel)}/] }
        message_stack = message.split(' ')

        current_message = message_stack.pop
        until (current_message.nil? && message_stack.empty?) || line_idx_stack.empty?
          current_line, idx = line_idx_stack.pop
          # TODO making an assumption that lines only have one place to replace text and it is contiguous
          current_line_capacity = current_line[/#{Regexp.escape(message_sentinel)}+/].length
          message_buffer = ''

          # until no more messages or buffer would overflow
          until current_message.nil? || (current_message.length + (message_buffer.length == 0 ? 0 : message_buffer.length + 1)) > current_line_capacity
            # add message to buffer
            if message_buffer.length > 0
              message_buffer = [current_message, message_buffer].join(' ')
            else
              message_buffer = current_message
            end
            current_message = message_stack.pop
          end

          # pad the buffer to capacity
          case alignment
          when :left
            message_buffer += ' ' * (current_line_capacity - message_buffer.length)
          when :right
            message_buffer.insert 0, ' ' * (current_line_capacity - message_buffer.length)
          else
            half = (current_line_capacity - message_buffer.length) / 2.0
            message_buffer.insert 0, ' ' * half.floor
            message_buffer += ' ' * half.ceil
          end

          # flush the buffer
          line = current_line.gsub(/#{Regexp.escape(message_sentinel * current_line_capacity)}/, message_buffer)
          body_buffer[idx] = line
        end

        if message_stack.empty?
          puts body_buffer.join
        else
          raise
        end
      else
        body = @body.tr(message_sentinel, ' ')
        body = body.tr(message_callout_sentinel, ' ') if message_callout_sentinel
        puts body
      end
    end

    alias :say :print

    def parse(template)
      headers, body = template.split("---\n")
      binding.eval headers
      @body = body
    end
  end
end
