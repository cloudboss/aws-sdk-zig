const aws = @import("aws");

/// The request parameters of TagResource.
pub const TagResourceRequest = struct {
    /// The Amazon Web Services Supply chain resource ARN that needs to be tagged.
    resource_arn: []const u8,

    /// The tags of the Amazon Web Services Supply chain resource to be created.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
