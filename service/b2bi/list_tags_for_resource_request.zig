pub const ListTagsForResourceRequest = struct {
    /// Requests the tags associated with a particular Amazon Resource Name (ARN).
    /// An ARN is an identifier for a specific Amazon Web Services resource, such as
    /// a capability, partnership, profile, or transformer.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
