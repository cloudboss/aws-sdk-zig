const Tag = @import("tag.zig").Tag;

/// The request information for tagging a rescore execution
/// plan. A rescore execution plan is an Amazon Kendra
/// Intelligent Ranking resource used for provisioning the
/// `Rescore` API.
pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the rescore execution
    /// plan to tag.
    resource_arn: []const u8,

    /// A list of tag keys to add to a rescore execution plan.
    /// If a tag already exists, the existing value is replaced
    /// with the new value.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
