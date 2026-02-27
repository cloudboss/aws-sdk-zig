const UsernamePassword = @import("username_password.zig").UsernamePassword;
const GovernanceType = @import("governance_type.zig").GovernanceType;
const ManagedEndpointCredentials = @import("managed_endpoint_credentials.zig").ManagedEndpointCredentials;

/// The Spark EMR properties.
pub const SparkEmrPropertiesOutput = struct {
    /// The certificate data of the EMR on EKS cluster.
    certificate_data: ?[]const u8,

    /// The compute ARN of the Spark EMR.
    compute_arn: ?[]const u8,

    /// The credentials of the Spark EMR.
    credentials: ?UsernamePassword,

    /// The credential expiration of the Spark EMR.
    credentials_expiration: ?i64,

    /// The governance type of the Spark EMR.
    governance_type: ?GovernanceType,

    /// The instance profile ARN of the Spark EMR.
    instance_profile_arn: ?[]const u8,

    /// The Java virtual env of the Spark EMR.
    java_virtual_env: ?[]const u8,

    /// The livy endpoint of the Spark EMR.
    livy_endpoint: ?[]const u8,

    /// The log URI of the Spark EMR.
    log_uri: ?[]const u8,

    /// The managed endpoint ARN of the EMR on EKS cluster.
    managed_endpoint_arn: ?[]const u8,

    /// The managed endpoint credentials of the EMR on EKS cluster.
    managed_endpoint_credentials: ?ManagedEndpointCredentials,

    /// The Python virtual env of the Spark EMR.
    python_virtual_env: ?[]const u8,

    /// The runtime role of the Spark EMR.
    runtime_role: ?[]const u8,

    /// The trusted certificate S3 URL of the Spark EMR.
    trusted_certificates_s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .certificate_data = "certificateData",
        .compute_arn = "computeArn",
        .credentials = "credentials",
        .credentials_expiration = "credentialsExpiration",
        .governance_type = "governanceType",
        .instance_profile_arn = "instanceProfileArn",
        .java_virtual_env = "javaVirtualEnv",
        .livy_endpoint = "livyEndpoint",
        .log_uri = "logUri",
        .managed_endpoint_arn = "managedEndpointArn",
        .managed_endpoint_credentials = "managedEndpointCredentials",
        .python_virtual_env = "pythonVirtualEnv",
        .runtime_role = "runtimeRole",
        .trusted_certificates_s3_uri = "trustedCertificatesS3Uri",
    };
};
