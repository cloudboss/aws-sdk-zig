const AwsAthenaWorkGroupConfigurationDetails = @import("aws_athena_work_group_configuration_details.zig").AwsAthenaWorkGroupConfigurationDetails;

/// Provides information about an Amazon Athena workgroup.
pub const AwsAthenaWorkGroupDetails = struct {
    /// The configuration of the workgroup, which includes the location in Amazon
    /// Simple Storage Service (Amazon S3)
    /// where query results are stored, the encryption option, if any, used for
    /// query results, whether
    /// Amazon CloudWatch metrics are enabled for the workgroup, and the limit for
    /// the amount of bytes scanned
    /// (cutoff) per query, if it is specified.
    configuration: ?AwsAthenaWorkGroupConfigurationDetails = null,

    /// The workgroup description.
    description: ?[]const u8 = null,

    /// The workgroup name.
    name: ?[]const u8 = null,

    /// Whether the workgroup is enabled or disabled.
    state: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .description = "Description",
        .name = "Name",
        .state = "State",
    };
};
