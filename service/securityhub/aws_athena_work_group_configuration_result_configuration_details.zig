const AwsAthenaWorkGroupConfigurationResultConfigurationEncryptionConfigurationDetails = @import("aws_athena_work_group_configuration_result_configuration_encryption_configuration_details.zig").AwsAthenaWorkGroupConfigurationResultConfigurationEncryptionConfigurationDetails;

/// The location in Amazon Simple Storage Service (Amazon S3) where query and
/// calculation results are stored and the encryption option, if any,
/// used for query and calculation results. These are known as client-side
/// settings. If workgroup settings override
/// client-side settings, then the query uses the workgroup settings.
pub const AwsAthenaWorkGroupConfigurationResultConfigurationDetails = struct {
    /// Specifies the method used to encrypt the user’s data stores in the Athena
    /// workgroup.
    encryption_configuration: ?AwsAthenaWorkGroupConfigurationResultConfigurationEncryptionConfigurationDetails = null,

    pub const json_field_names = .{
        .encryption_configuration = "EncryptionConfiguration",
    };
};
