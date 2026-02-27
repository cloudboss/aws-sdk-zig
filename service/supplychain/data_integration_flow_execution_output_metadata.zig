/// The output metadata of the flow execution.
pub const DataIntegrationFlowExecutionOutputMetadata = struct {
    /// The S3 URI under which all diagnostic files (such as deduped records if any)
    /// are stored.
    diagnostic_reports_root_s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .diagnostic_reports_root_s3_uri = "diagnosticReportsRootS3URI",
    };
};
