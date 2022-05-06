hello = (x: string, y: string, z: string) => {
    print(x);
    print(y);
    return 0;
};

main = (argc: int, argv: Array<string>): int => {
    hello("hello world!\n", "printing y\n", "3rd arg!");
    print("Hello from main!\n");
    return 0;
};