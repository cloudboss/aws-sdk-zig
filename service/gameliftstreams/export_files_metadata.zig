const ExportFilesStatus = @import("export_files_status.zig").ExportFilesStatus;

/// Provides details about the stream session's exported files.
pub const ExportFilesMetadata = struct {
    /// The S3 bucket URI where Amazon GameLift Streams uploaded the set of
    /// compressed exported files for a stream session. Amazon GameLift Streams
    /// generates a ZIP file name based on the stream session metadata.
    /// Alternatively, you can provide a custom file name with a `.zip` file
    /// extension.
    ///
    /// Example 1: If you provide an S3 URI called
    /// `s3://amzn-s3-demo-destination-bucket/MyGame_Session1.zip`, then Amazon
    /// GameLift Streams will save the files at that location.
    ///
    /// Example 2: If you provide an S3 URI called
    /// `s3://amzn-s3-demo-destination-bucket/MyGameSessions_ExportedFiles/`, then
    /// Amazon GameLift Streams will save the files at
    /// `s3://amzn-s3-demo-destination-bucket/MyGameSessions_ExportedFiles/YYYYMMDD-HHMMSS-appId-sg-Id-sessionId.zip` or another similar name.
    output_uri: ?[]const u8,

    /// The result of the
    /// [ExportStreamSessionFiles](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_ExportStreamSessionFiles.html) operation.
    status: ?ExportFilesStatus,

    /// A short description of the reason the export is in `FAILED` status.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .output_uri = "OutputUri",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
