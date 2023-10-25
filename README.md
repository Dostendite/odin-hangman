# Odin Hangman

## Ruby hangman game

```
     ____________               
     | /       _|_              
     |/       /   \             
     |        \___/             
     |         /|\              
     |        / | \             
     |       /  |  \            
     |         / \              
     |        /   \             
     |\      /     \            
     |_\___________________  

     Help save the ragdoll from linguistic execution!
```

### Known bugs:
- If the user inputs the "save_command" after entering
invalid input when asked for a guess, the command itself
is added to the wrong guesses array of the Game object

### Possible improvements:
1. Add a "main_menu" command that the user can use to exit the current game
2. Create more methods for common operations (especailly in the SaveGame module)
3. Possibly even create a class to handle the Game objects & main menu
4. Add methods to validate user input
