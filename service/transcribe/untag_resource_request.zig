pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Transcribe resource you want to
    /// remove
    /// tags from. ARNs have the format
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

    /// Removes the specified tag keys from the specified Amazon Transcribe
    /// resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
