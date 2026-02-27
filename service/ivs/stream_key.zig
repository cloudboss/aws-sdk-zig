const aws = @import("aws");

/// Object specifying a stream key.
pub const StreamKey = struct {
    /// Stream-key ARN.
    arn: ?[]const u8,

    /// Channel ARN for the stream.
    channel_arn: ?[]const u8,

    /// Tags attached to the resource. Array of 1-50 maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no
    /// service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry,

    /// Stream-key value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .channel_arn = "channelArn",
        .tags = "tags",
        .value = "value",
    };
};
