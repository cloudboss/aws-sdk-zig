pub const LocationFilter = enum {
    aws,
    custom,

    pub const json_field_names = .{
        .aws = "AWS",
        .custom = "CUSTOM",
    };
};
