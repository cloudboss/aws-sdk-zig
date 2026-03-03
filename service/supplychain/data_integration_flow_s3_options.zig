const DataIntegrationFlowFileType = @import("data_integration_flow_file_type.zig").DataIntegrationFlowFileType;

/// The Amazon S3 options used in S3 source and target configurations.
pub const DataIntegrationFlowS3Options = struct {
    /// The Amazon S3 file type in S3 options.
    file_type: ?DataIntegrationFlowFileType = null,

    pub const json_field_names = .{
        .file_type = "fileType",
    };
};
