# frozen_string_literal: true

# Placeholder file for Ragdoll class

def print_ragdoll
  canvas_lines = [
    '     ____________               ',
    '     | /       _|_              ',
    '     |/       /   \             ',
    '     |        \___/             ',
    '     |         /|\              ',
    '     |        / | \             ',
    '     |       /  |  \            ',
    '     |         / \              ',
    '     |        /   \             ',
    '     |\      /     \            ',
    '     |_\___________________     ',
    '                                '
  ]

  system 'clear'

  canvas_lines.each { |line| puts line }
end

print_ragdoll
