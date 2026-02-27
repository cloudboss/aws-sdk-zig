pub const VariationValueType = enum {
    string,
    long,
    double,
    boolean,

    pub const json_field_names = .{
        .string = "STRING",
        .long = "LONG",
        .double = "DOUBLE",
        .boolean = "BOOLEAN",
    };
};
