hello = (x: string, y: string) => {
    print(y);
    return 0;
};

main = (argc: int, argv: Array<string>): int => {
    hello("hello world!\n", "printing y\n");
    print("Hello from main!\n");
    return 0;
};