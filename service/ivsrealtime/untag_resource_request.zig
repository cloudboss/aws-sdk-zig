pub const UntagResourceRequest = struct {
    /// The ARN of the resource to be untagged. The ARN must be URL-encoded.
    resource_arn: []const u8,

    /// Array of tag keys (strings) for the tags to be removed.
    /// See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html)
    /// in *Tagging AWS Resources and Tag Editor* for details, including
    /// restrictions that apply to tags and "Tag naming
    /// limits and requirements"; Amazon IVS has no constraints on tags beyond what
    /// is documented
    /// there.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
