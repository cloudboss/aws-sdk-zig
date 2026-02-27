pub const Ownership = enum {
    self,
    shared,
    amazon,
    thirdparty,
    aws_marketplace,

    pub const json_field_names = .{
        .self = "SELF",
        .shared = "SHARED",
        .amazon = "AMAZON",
        .thirdparty = "THIRDPARTY",
        .aws_marketplace = "AWS_MARKETPLACE",
    };
};
