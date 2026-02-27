pub const UserPoolTierType = enum {
    lite,
    essentials,
    plus,

    pub const json_field_names = .{
        .lite = "LITE",
        .essentials = "ESSENTIALS",
        .plus = "PLUS",
    };
};
