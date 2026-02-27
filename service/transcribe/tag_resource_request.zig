const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource you want to tag. ARNs have
    /// the format
    /// `arn:partition:service:region:account-id:resource-type/resource-id`.
    ///
    /// For example,
    /// `arn:aws:transcribe:us-west-2:111122223333:transcription-job/transcription-job-name`.
    ///
    /// Valid values for `resource-type` are: `transcription-job`,
    /// `medical-transcription-job`, `vocabulary`,
    /// `medical-vocabulary`, `vocabulary-filter`, and
    /// `language-model`.
    resource_arn: []const u8,

    /// Adds one or more custom tags, each in the form of a key:value pair, to the
    /// specified
    /// resource.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
