/// The Spark EMR properties patch.
pub const SparkEmrPropertiesPatch = struct {
    /// The compute ARN in the Spark EMR properties patch.
    compute_arn: ?[]const u8,

    /// The instance profile ARN in the Spark EMR properties patch.
    instance_profile_arn: ?[]const u8,

    /// The Java virtual evn in the Spark EMR properties patch.
    java_virtual_env: ?[]const u8,

    /// The log URI in the Spark EMR properties patch.
    log_uri: ?[]const u8,

    /// The managed endpoint ARN of the EMR on EKS cluster.
    managed_endpoint_arn: ?[]const u8,

    /// The Python virtual env in the Spark EMR properties patch.
    python_virtual_env: ?[]const u8,

    /// The runtime role in the Spark EMR properties patch.
    runtime_role: ?[]const u8,

    /// The trusted certificates S3 URI in the Spark EMR properties patch.
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
