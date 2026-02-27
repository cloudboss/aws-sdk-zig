pub const ListTagsForResourceRequest = struct {
    /// The ARN of the media pipeline associated with any tags. The ARN consists of
    /// the pipeline's region, resource ID, and pipeline ID.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
