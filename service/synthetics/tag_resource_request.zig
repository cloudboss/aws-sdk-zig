const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the canary or group that you're adding tags to.
    ///
    /// The ARN format of a canary is
    /// `arn:aws:synthetics:*Region*:*account-id*:canary:*canary-name*
    /// `.
    ///
    /// The ARN format of a group is
    /// `arn:aws:synthetics:*Region*:*account-id*:group:*group-name*
    /// `
    resource_arn: []const u8,

    /// The list of key-value pairs to associate with the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
