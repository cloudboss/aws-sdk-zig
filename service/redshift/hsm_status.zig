/// Describes the status of changes to HSM settings.
pub const HsmStatus = struct {
    /// Specifies the name of the HSM client certificate the Amazon Redshift cluster
    /// uses to
    /// retrieve the data encryption keys stored in an HSM.
    hsm_client_certificate_identifier: ?[]const u8 = null,

    /// Specifies the name of the HSM configuration that contains the information
    /// the
    /// Amazon Redshift cluster can use to retrieve and store keys in an HSM.
    hsm_configuration_identifier: ?[]const u8 = null,

    /// Reports whether the Amazon Redshift cluster has finished applying any HSM
    /// settings
    /// changes specified in a modify cluster command.
    ///
    /// Values: active, applying
    status: ?[]const u8 = null,
};
