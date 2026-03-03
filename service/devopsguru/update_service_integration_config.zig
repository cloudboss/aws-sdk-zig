const KMSServerSideEncryptionIntegrationConfig = @import("kms_server_side_encryption_integration_config.zig").KMSServerSideEncryptionIntegrationConfig;
const LogsAnomalyDetectionIntegrationConfig = @import("logs_anomaly_detection_integration_config.zig").LogsAnomalyDetectionIntegrationConfig;
const OpsCenterIntegrationConfig = @import("ops_center_integration_config.zig").OpsCenterIntegrationConfig;

/// Information about updating the integration status of an Amazon Web Services
/// service, such as
/// Amazon Web Services Systems Manager, with DevOps Guru.
pub const UpdateServiceIntegrationConfig = struct {
    /// Information about whether DevOps Guru is configured to encrypt server-side
    /// data using KMS.
    kms_server_side_encryption: ?KMSServerSideEncryptionIntegrationConfig = null,

    /// Information about whether DevOps Guru is configured to perform log anomaly
    /// detection on Amazon CloudWatch log groups.
    logs_anomaly_detection: ?LogsAnomalyDetectionIntegrationConfig = null,

    ops_center: ?OpsCenterIntegrationConfig = null,

    pub const json_field_names = .{
        .kms_server_side_encryption = "KMSServerSideEncryption",
        .logs_anomaly_detection = "LogsAnomalyDetection",
        .ops_center = "OpsCenter",
    };
};
