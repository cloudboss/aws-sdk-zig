/// Information about whether an Amazon Redshift cluster finished applying any
/// hardware
/// changes to security module (HSM) settings that were specified in a modify
/// cluster
/// command.
pub const AwsRedshiftClusterHsmStatus = struct {
    /// The name of the HSM client certificate that the Amazon Redshift cluster uses
    /// to retrieve
    /// the data encryption keys that are stored in an HSM.
    hsm_client_certificate_identifier: ?[]const u8,

    /// The name of the HSM configuration that contains the information that the
    /// Amazon Redshift
    /// cluster can use to retrieve and store keys in an HSM.
    hsm_configuration_identifier: ?[]const u8,

    /// Indicates whether the Amazon Redshift cluster has finished applying any HSM
    /// settings
    /// changes specified in a modify cluster command.
    ///
    /// Type: String
    ///
    /// Valid values: `active` | `applying`
    status: ?[]const u8,

    pub const json_field_names = .{
        .hsm_client_certificate_identifier = "HsmClientCertificateIdentifier",
        .hsm_configuration_identifier = "HsmConfigurationIdentifier",
        .status = "Status",
    };
};
