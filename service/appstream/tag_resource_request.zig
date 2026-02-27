const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// The tags to associate. A tag is a key-value pair, and the value is optional.
    /// For example, Environment=Test. If you do not specify a value, Environment=.
    ///
    /// If you do not specify a value, the value is set to an empty string.
    ///
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in UTF-8, and the following special characters:
    ///
    /// _ . : / = + \ - @
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
