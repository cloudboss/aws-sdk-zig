pub const LensType = enum {
    aws_official,
    custom_shared,
    custom_self,

    pub const json_field_names = .{
        .aws_official = "AWS_OFFICIAL",
        .custom_shared = "CUSTOM_SHARED",
        .custom_self = "CUSTOM_SELF",
    };
};
