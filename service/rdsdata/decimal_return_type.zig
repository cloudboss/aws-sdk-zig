pub const DecimalReturnType = enum {
    string,
    double_or_long,

    pub const json_field_names = .{
        .string = "STRING",
        .double_or_long = "DOUBLE_OR_LONG",
    };
};
