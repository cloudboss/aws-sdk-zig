pub const ParameterType = enum {
    datetime,
    number,
    string,

    pub const json_field_names = .{
        .datetime = "Datetime",
        .number = "Number",
        .string = "String",
    };
};
