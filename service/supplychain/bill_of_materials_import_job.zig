const ConfigurationJobStatus = @import("configuration_job_status.zig").ConfigurationJobStatus;

/// The BillOfMaterialsImportJob details.
pub const BillOfMaterialsImportJob = struct {
    /// The BillOfMaterialsImportJob instanceId.
    instance_id: []const u8,

    /// The BillOfMaterialsImportJob jobId.
    job_id: []const u8,

    /// When the BillOfMaterialsImportJob has reached a terminal state, there will
    /// be a message.
    message: ?[]const u8,

    /// The S3 URI from which the CSV is read.
    s_3_uri: []const u8,

    /// The BillOfMaterialsImportJob ConfigurationJobStatus.
    status: ConfigurationJobStatus,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .job_id = "jobId",
        .message = "message",
        .s_3_uri = "s3uri",
        .status = "status",
    };
};
