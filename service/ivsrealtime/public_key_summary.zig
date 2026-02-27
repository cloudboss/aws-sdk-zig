const aws = @import("aws");

/// Summary information about a public key.
pub const PublicKeySummary = struct {
    /// Public key ARN.
    arn: ?[]const u8,

    /// Public key name.
    name: ?[]const u8,

    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging AWS Resources and Tag
    /// Editor* for details, including restrictions that apply to tags and "Tag
    /// naming
    /// limits and requirements"; Amazon IVS has no constraints on tags beyond what
    /// is documented
    /// there.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .tags = "tags",
    };
};
