pub const RuleConfigurationPropertyType = enum {
    string,
    number,
    boolean,

    pub const json_field_names = .{
        .string = "String",
        .number = "Number",
        .boolean = "Boolean",
    };
};
