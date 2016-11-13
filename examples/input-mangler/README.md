The input mangler is the simplest illustrative proof of concept of how ports work in Elm, and how to create a simple program that interoperates between Elm and JavaScript, without being tied to a concept of HTML.

All it does is take input from the user, mangle that String and send it back to the user. Elm does the mangling, while NodeJS handles the input from, and output to the user.

It uses SimplePortProgram to create a simple program that subscribes to input, and publishes what it mangles.

To see it in action:

    $ ./run.sh

If you're on Windows, read that run.sh file, and manually execute those commands.
