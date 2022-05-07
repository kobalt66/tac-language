hello = (x: string, y: string, z: string, w: string, v: string, vv: string) => {
    print(x);
    print(y);
    print(z);
    print(w);
    print(v);
    print(vv);
    return 0;
};

main = (argc: int, argv: Array<string>): int => {
    hello("hello world is also very long compared to other arguments in this function call!!\n", "printing y is a bit longer than other arguments of this function call...\n", "3rd arg!\n", "4th arg!\n", "5th arg!\n", "6th arg!\n");
    print("Hello from main!\n");
    return 0;
};