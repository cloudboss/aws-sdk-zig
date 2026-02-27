pub const UntagResourceRequest = struct {
    /// The ARN of the canary or group that you're removing tags from.
    ///
    /// The ARN format of a canary is
    /// `arn:aws:synthetics:*Region*:*account-id*:canary:*canary-name*
    /// `.
    ///
    /// The ARN format of a group is
    /// `arn:aws:synthetics:*Region*:*account-id*:group:*group-name*
    /// `
    resource_arn: []const u8,

    /// The list of tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
