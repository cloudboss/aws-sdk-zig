pub const UntagResourceRequest = struct {
    /// The Timestream resource that the tags will be removed from. This value is an
    /// Amazon
    /// Resource Name (ARN).
    resource_arn: []const u8,

    /// A list of tags keys. Existing tags of the resource whose keys are members of
    /// this list
    /// will be removed from the Timestream resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
