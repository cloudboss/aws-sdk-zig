pub const SchemaValueType = enum {
    /// LONG type
    long,
    /// INT type
    int,
    /// STRING type
    string,
    /// FLOAT type
    float,
    /// DOUBLE type
    double,
    /// BOOLEAN type
    boolean,

    pub const json_field_names = .{
        .long = "LONG",
        .int = "INT",
        .string = "STRING",
        .float = "FLOAT",
        .double = "DOUBLE",
        .boolean = "BOOLEAN",
    };
};
