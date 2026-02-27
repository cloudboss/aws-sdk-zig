/// The Spark EMR properties.
pub const SparkEmrPropertiesInput = struct {
    /// The compute ARN of Spark EMR.
    compute_arn: ?[]const u8,

    /// The instance profile ARN of Spark EMR.
    instance_profile_arn: ?[]const u8,

    /// The java virtual env of the Spark EMR.
    java_virtual_env: ?[]const u8,

    /// The log URI of the Spark EMR.
    log_uri: ?[]const u8,

    /// The managed endpoint ARN of the EMR on EKS cluster.
    managed_endpoint_arn: ?[]const u8,

    /// The Python virtual env of the Spark EMR.
    python_virtual_env: ?[]const u8,

    /// The runtime role of the Spark EMR.
    runtime_role: ?[]const u8,

    /// The certificates S3 URI of the Spark EMR.
    trusted_certificates_s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .compute_arn = "computeArn",
        .instance_profile_arn = "instanceProfileArn",
        .java_virtual_env = "javaVirtualEnv",
        .log_uri = "logUri",
        .managed_endpoint_arn = "managedEndpointArn",
        .python_virtual_env = "pythonVirtualEnv",
        .runtime_role = "runtimeRole",
        .trusted_certificates_s3_uri = "trustedCertificatesS3Uri",
    };
};
