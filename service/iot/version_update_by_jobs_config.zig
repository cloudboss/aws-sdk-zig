/// Configuration to manage IoT Job's package version reporting. If configured,
/// Jobs updates the thing's reserved named shadow with the package version
/// information up on successful job completion.
///
/// **Note:** For each job, the destinationPackageVersions attribute has to be
/// set with the correct data for Jobs to report to the thing shadow.
pub const VersionUpdateByJobsConfig = struct {
    /// Indicates whether the Job is enabled or not.
    enabled: ?bool,

    /// The Amazon Resource Name (ARN) of the role that grants permission to the IoT
    /// jobs service to update the reserved named shadow when the job successfully
    /// completes.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "enabled",
        .role_arn = "roleArn",
    };
};
