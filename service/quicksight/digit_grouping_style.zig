pub const DigitGroupingStyle = enum {
    default,
    lakhs,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .lakhs = "LAKHS",
    };
};
