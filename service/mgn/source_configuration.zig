const SourceEnvironment = @import("source_environment.zig").SourceEnvironment;
const SourceS3Configuration = @import("source_s3_configuration.zig").SourceS3Configuration;

/// Configuration for a migration source environment.
pub const SourceConfiguration = struct {
    /// The source environment type.
    source_environment: SourceEnvironment,

    /// The S3 configuration for the source data.
    source_s3_configuration: SourceS3Configuration,

    pub const json_field_names = .{
        .source_environment = "sourceEnvironment",
        .source_s3_configuration = "sourceS3Configuration",
    };
};
