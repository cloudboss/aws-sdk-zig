/// [Tag-level retention rules only] Information about the resource tags used to
/// identify resources that are retained by the retention
/// rule.
pub const ResourceTag = struct {
    /// The tag key.
    resource_tag_key: []const u8,

    /// The tag value.
    resource_tag_value: ?[]const u8,

    pub const json_field_names = .{
        .resource_tag_key = "ResourceTagKey",
        .resource_tag_value = "ResourceTagValue",
    };
};
