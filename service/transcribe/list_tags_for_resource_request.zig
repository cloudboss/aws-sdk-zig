pub const ListTagsForResourceRequest = struct {
    /// Returns a list of all tags associated with the specified Amazon Resource
    /// Name (ARN).
    /// ARNs have the format
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

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
