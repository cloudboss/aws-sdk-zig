const AwsAthenaWorkGroupConfigurationResultConfigurationDetails = @import("aws_athena_work_group_configuration_result_configuration_details.zig").AwsAthenaWorkGroupConfigurationResultConfigurationDetails;

/// The configuration of the workgroup, which includes the location in Amazon
/// Simple Storage Service (Amazon S3) where
/// query results are stored, the encryption option, if any, used for query
/// results, whether Amazon CloudWatch
/// metrics are enabled for the workgroup, and the limit for the amount of bytes
/// scanned (cutoff) per query, if it is
/// specified.
pub const AwsAthenaWorkGroupConfigurationDetails = struct {
    /// The location in Amazon S3 where query and calculation results are stored and
    /// the
    /// encryption option, if any, used for query and calculation results. These are
    /// known as client-side settings. If
    /// workgroup settings override client-side settings, then the query uses the
    /// workgroup settings.
    result_configuration: ?AwsAthenaWorkGroupConfigurationResultConfigurationDetails,

    pub const json_field_names = .{
        .result_configuration = "ResultConfiguration",
    };
};
