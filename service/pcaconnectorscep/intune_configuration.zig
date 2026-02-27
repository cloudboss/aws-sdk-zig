/// Contains configuration details for use with Microsoft Intune. For
/// information about using Connector for SCEP for Microsoft Intune, see [Using
/// Connector for SCEP for Microsoft
/// Intune](https://docs.aws.amazon.com/privateca/latest/userguide/scep-connector.htmlconnector-for-scep-intune.html).
///
/// When you use Connector for SCEP for Microsoft Intune, certain
/// functionalities are enabled by accessing Microsoft Intune through the
/// Microsoft API. Your use of the Connector for SCEP and accompanying Amazon
/// Web Services services doesn't remove your need to have a valid license for
/// your use of the Microsoft Intune service. You should also review the
/// [Microsoft Intune® App Protection
/// Policies](https://learn.microsoft.com/en-us/mem/intune/apps/app-protection-policy).
pub const IntuneConfiguration = struct {
    /// The directory (tenant) ID from your Microsoft Entra ID app registration.
    azure_application_id: []const u8,

    /// The primary domain from your Microsoft Entra ID app registration.
    domain: []const u8,

    pub const json_field_names = .{
        .azure_application_id = "AzureApplicationId",
        .domain = "Domain",
    };
};
