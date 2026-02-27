const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource to be tagged. The ARN must be URL-encoded.
    resource_arn: []const u8,

    /// Array of tags to be added or updated. Array of maps, each of the form
    /// `string:string (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS Chat has no constraints beyond what is documented
    /// there.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
