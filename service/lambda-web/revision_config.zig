const BuildConfig = @import("build_config.zig").BuildConfig;
const ServiceConfig = @import("service_config.zig").ServiceConfig;

/// The configuration for a web function revision, including code build settings
/// and service configuration.
pub const RevisionConfig = struct {
    /// The build configuration for the revision.
    build_config: BuildConfig,

    /// A description of the revision.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the AWS Key Management Service (AWS KMS)
    /// key used to encrypt the revision's code and environment variables.
    kms_key_arn: ?[]const u8 = null,

    /// The service configuration for the revision.
    service_config: ServiceConfig,

    pub const json_field_names = .{
        .build_config = "buildConfig",
        .description = "description",
        .kms_key_arn = "kmsKeyArn",
        .service_config = "serviceConfig",
    };
};
