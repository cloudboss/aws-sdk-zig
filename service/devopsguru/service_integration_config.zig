const KMSServerSideEncryptionIntegration = @import("kms_server_side_encryption_integration.zig").KMSServerSideEncryptionIntegration;
const LogsAnomalyDetectionIntegration = @import("logs_anomaly_detection_integration.zig").LogsAnomalyDetectionIntegration;
const OpsCenterIntegration = @import("ops_center_integration.zig").OpsCenterIntegration;

/// Information about the integration of DevOps Guru with another Amazon Web
/// Services service, such as
/// Amazon Web Services Systems Manager.
pub const ServiceIntegrationConfig = struct {
    /// Information about whether DevOps Guru is configured to encrypt server-side
    /// data using KMS.
    kms_server_side_encryption: ?KMSServerSideEncryptionIntegration = null,

    /// Information about whether DevOps Guru is configured to perform log anomaly
    /// detection on Amazon CloudWatch log groups.
    logs_anomaly_detection: ?LogsAnomalyDetectionIntegration = null,

    /// Information about whether DevOps Guru is configured to create an OpsItem in
    /// Amazon Web Services Systems Manager
    /// OpsCenter for each created insight.
    ops_center: ?OpsCenterIntegration = null,

    pub const json_field_names = .{
        .kms_server_side_encryption = "KMSServerSideEncryption",
        .logs_anomaly_detection = "LogsAnomalyDetection",
        .ops_center = "OpsCenter",
    };
};
