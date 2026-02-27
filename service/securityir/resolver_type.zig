pub const ResolverType = enum {
    aws,
    self,

    pub const json_field_names = .{
        .aws = "AWS",
        .self = "SELF",
    };
};
