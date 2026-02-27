pub const DisplayFormat = enum {
    auto,
    percent,
    currency,
    number,
    date,
    string,

    pub const json_field_names = .{
        .auto = "AUTO",
        .percent = "PERCENT",
        .currency = "CURRENCY",
        .number = "NUMBER",
        .date = "DATE",
        .string = "STRING",
    };
};
