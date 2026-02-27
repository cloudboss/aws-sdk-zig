/// Contains configuration information for the default behavior of the CRL
/// Distribution Point (CDP) extension in certificates issued by your CA. This
/// extension contains a link to download the CRL, so you can check whether a
/// certificate has been revoked. To choose whether you want this extension
/// omitted or not in certificates issued by your CA, you can set the
/// **OmitExtension** parameter.
pub const CrlDistributionPointExtensionConfiguration = struct {
    /// Configures whether the CRL Distribution Point extension should be populated
    /// with the default URL to the CRL. If set to `true`, then the CDP extension
    /// will not be present in any certificates issued by that CA unless otherwise
    /// specified through CSR or API passthrough.
    ///
    /// Only set this if you have another way to distribute the CRL Distribution
    /// Points ffor certificates issued by your CA, such as the Matter Distributed
    /// Compliance Ledger
    ///
    /// This configuration cannot be enabled with a custom CNAME set.
    omit_extension: bool,

    pub const json_field_names = .{
        .omit_extension = "OmitExtension",
    };
};
