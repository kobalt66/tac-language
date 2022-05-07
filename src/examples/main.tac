hello = (x: string, y: string, z: string, w: string, v: string) => {
    print(x);
    print(y);
    print(z);
    print(w);
    print(v);
    return 0;
};

main = (argc: int, argv: Array<string>): int => {
    hello("hello world!\n", "printing y\n", "3rd arg!\n", "4th arg!\n", "5th arg!\n");
    print("Hello from main!\n");
    return 0;
};