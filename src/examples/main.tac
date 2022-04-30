something = () : int => {
    print("Calling something!\n");
    return 1;
};

main = (argc: int, argv: Array<string>): int => {
    something();
    return 16;
};