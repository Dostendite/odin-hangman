# frozen_string_literal: true

# Holds all strings to draw the ragdoll
module RagdollPrint
  @@ragdoll_strings = [
    [
      '                                ',
      '                                ',
      '                                ',
      '                                ',
      '                                ',
      '                                ',
      '                                ',
      '                                ',
      '                                ',
      '                                ',
      '     ______________________     ',
      '                                ',
      'Lives left: 10'
    ],
    [
      '                                ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |_____________________     ',
      '                                ',
      'Lives left: 9'
    ],
    [
      '                                ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |\                         ',
      '     |_\___________________     ',
      '                                ',
      'Lives left: 8'
    ],
    [
      '     ____________               ',
      '     | /                        ',
      '     |/                         ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |\                         ',
      '     |_\___________________     ',
      '                                ',
      'Lives left: 7'
    ],
    [
      '     ____________               ',
      '     | /        |               ',
      '     |/                         ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |\                         ',
      '     |_\___________________     ',
      '                                ',
      'Lives left: 6'
    ],
    [
      '     ____________               ',
      '     | /       _|_              ',
      '     |/       /   \             ',
      '     |        \___/             ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |                          ',
      '     |\                         ',
      '     |_\___________________     ',
      '                                ',
      'Lives left: 5'
    ],
    [
      '     ____________               ',
      '     | /       _|_              ',
      '     |/       /   \             ',
      '     |        \___/             ',
      '     |          |               ',
      '     |          |               ',
      '     |          |               ',
      '     |                          ',
      '     |                          ',
      '     |\                         ',
      '     |_\___________________     ',
      '                                ',
      'Lives left: 4'
    ],
    [
      '     ____________               ',
      '     | /       _|_              ',
      '     |/       /   \             ',
      '     |        \___/             ',
      '     |          |               ',
      '     |          |               ',
      '     |          |               ',
      '     |         /                ',
      '     |        /                 ',
      '     |\      /                  ',
      '     |_\___________________     ',
      '                                ',
      'Lives left: 3'
    ],
    [
      '     ____________               ',
      '     | /       _|_              ',
      '     |/       /   \             ',
      '     |        \___/             ',
      '     |          |               ',
      '     |          |               ',
      '     |          |               ',
      '     |         / \              ',
      '     |        /   \             ',
      '     |\      /     \            ',
      '     |_\___________________     ',
      '                                ',
      'Lives left: 2'
    ],
    [
      '     ____________               ',
      '     | /       _|_              ',
      '     |/       /   \             ',
      '     |        \___/             ',
      '     |         /|               ',
      '     |        / |               ',
      '     |       /  |               ',
      '     |         / \              ',
      '     |        /   \             ',
      '     |\      /     \            ',
      '     |_\___________________     ',
      '                                ',
      'Lives left: 1'
    ],
    [
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
      '                                ',
      'Lives left: 0'
    ]
  ]

  def print_ragdoll(lives_left)
    system 'clear'
    @@ragdoll_strings[10 - lives_left].each { |line| puts line }
  end
end