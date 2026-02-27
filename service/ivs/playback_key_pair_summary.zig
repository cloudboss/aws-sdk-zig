const aws = @import("aws");

/// Summary information about a playback key pair.
pub const PlaybackKeyPairSummary = struct {
    /// Key-pair ARN.
    arn: ?[]const u8,

    /// Playback-key-pair name. The value does not need to be unique.
    name: ?[]const u8,

    /// Tags attached to the resource. Array of 1-50 maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no
    /// service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .tags = "tags",
    };
};
