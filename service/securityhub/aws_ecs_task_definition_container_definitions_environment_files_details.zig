/// A file that contain environment variables to pass to a container.
pub const AwsEcsTaskDefinitionContainerDefinitionsEnvironmentFilesDetails = struct {
    /// The type of environment file. The valid value is `s3`.
    @"type": ?[]const u8 = null,

    /// The ARN of the S3 object that contains the environment variable file.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
