const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource or resources to which to add
    /// tags. You can associate tags
    /// with the following Device Farm resources: `PROJECT`, `TESTGRID_PROJECT`,
    /// `RUN`,
    /// `NETWORK_PROFILE`, `INSTANCE_PROFILE`, `DEVICE_INSTANCE`,
    /// `SESSION`, `DEVICE_POOL`, `DEVICE`, and
    /// `VPCE_CONFIGURATION`.
    resource_arn: []const u8,

    /// The tags to add to the resource. A tag is an array of key-value pairs. Tag
    /// keys can have a maximum
    /// character length of 128 characters. Tag values can have a maximum length of
    /// 256 characters.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
