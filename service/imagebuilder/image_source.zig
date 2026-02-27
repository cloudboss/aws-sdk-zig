pub const ImageSource = enum {
    amazon_managed,
    aws_marketplace,
    imported,
    custom,

    pub const json_field_names = .{
        .amazon_managed = "AMAZON_MANAGED",
        .aws_marketplace = "AWS_MARKETPLACE",
        .imported = "IMPORTED",
        .custom = "CUSTOM",
    };
};
