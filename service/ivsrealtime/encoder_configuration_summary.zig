const aws = @import("aws");

/// Summary information about an EncoderConfiguration.
pub const EncoderConfigurationSummary = struct {
    /// ARN of the EncoderConfiguration resource.
    arn: []const u8,

    /// Optional name to identify the resource.
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
