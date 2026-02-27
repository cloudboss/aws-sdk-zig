pub const ServiceTierType = enum {
    priority,
    default,
    flex,
    reserved,

    pub const json_field_names = .{
        .priority = "PRIORITY",
        .default = "DEFAULT",
        .flex = "FLEX",
        .reserved = "RESERVED",
    };
};
