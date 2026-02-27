/// Summary of the AWS resource used for access control that is implicitly
/// linked to your
/// AWS account.
pub const ProgressUpdateStreamSummary = struct {
    /// The name of the ProgressUpdateStream. *Do not store personal data in this
    /// field.*
    progress_update_stream_name: ?[]const u8,

    pub const json_field_names = .{
        .progress_update_stream_name = "ProgressUpdateStreamName",
    };
};
