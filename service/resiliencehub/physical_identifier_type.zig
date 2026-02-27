pub const PhysicalIdentifierType = enum {
    arn,
    native,

    pub const json_field_names = .{
        .arn = "ARN",
        .native = "NATIVE",
    };
};
