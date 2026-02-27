const IntuneConfiguration = @import("intune_configuration.zig").IntuneConfiguration;

/// If you don't supply a value, by default Connector for SCEP creates a
/// connector for general-purpose use. A general-purpose connector is designed
/// to work with clients or endpoints that support the SCEP protocol, except
/// Connector for SCEP for Microsoft Intune. For information about
/// considerations and limitations with using Connector for SCEP, see
/// [Considerations and
/// Limitations](https://docs.aws.amazon.com/privateca/latest/userguide/scep-connector.htmlc4scep-considerations-limitations.html).
///
/// If you provide an `IntuneConfiguration`, Connector for SCEP creates a
/// connector for use with Microsoft Intune, and you manage the challenge
/// passwords using Microsoft Intune. For more information, see [Using Connector
/// for SCEP for Microsoft
/// Intune](https://docs.aws.amazon.com/privateca/latest/userguide/scep-connector.htmlconnector-for-scep-intune.html).
pub const MobileDeviceManagement = union(enum) {
    /// Configuration settings for use with Microsoft Intune. For information about
    /// using Connector for SCEP for Microsoft Intune, see [Using Connector for SCEP
    /// for Microsoft
    /// Intune](https://docs.aws.amazon.com/privateca/latest/userguide/scep-connector.htmlconnector-for-scep-intune.html).
    intune: ?IntuneConfiguration,

    pub const json_field_names = .{
        .intune = "Intune",
    };
};
