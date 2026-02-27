pub const OriginEnvironment = enum {
    on_premises,
    aws,

    pub const json_field_names = .{
        .on_premises = "ON_PREMISES",
        .aws = "AWS",
    };
};
