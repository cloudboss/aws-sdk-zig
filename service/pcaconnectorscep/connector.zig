const MobileDeviceManagement = @import("mobile_device_management.zig").MobileDeviceManagement;
const OpenIdConfiguration = @import("open_id_configuration.zig").OpenIdConfiguration;
const ConnectorStatus = @import("connector_status.zig").ConnectorStatus;
const ConnectorStatusReason = @import("connector_status_reason.zig").ConnectorStatusReason;
const ConnectorType = @import("connector_type.zig").ConnectorType;

/// Connector for SCEP is a service that links Amazon Web Services Private
/// Certificate Authority to your SCEP-enabled devices. The connector brokers
/// the exchange of certificates from Amazon Web Services Private CA to your
/// SCEP-enabled devices and mobile device management systems. The connector is
/// a complex type that contains the connector's configuration settings.
pub const Connector = struct {
    /// The Amazon Resource Name (ARN) of the connector.
    arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the certificate authority associated with
    /// the connector.
    certificate_authority_arn: ?[]const u8,

    /// The date and time that the connector was created.
    created_at: ?i64,

    /// The connector's HTTPS public SCEP URL.
    endpoint: ?[]const u8,

    /// Contains settings relevant to the mobile device management system that you
    /// chose for the connector. If you didn't configure `MobileDeviceManagement`,
    /// then the connector is for general-purpose use and this object is empty.
    mobile_device_management: ?MobileDeviceManagement,

    /// Contains OpenID Connect (OIDC) parameters for use with Connector for SCEP
    /// for Microsoft Intune. For more information about using Connector for SCEP
    /// for Microsoft Intune, see [Using Connector for SCEP for Microsoft
    /// Intune](https://docs.aws.amazon.com/privateca/latest/userguide/scep-connector.htmlconnector-for-scep-intune.html).
    open_id_configuration: ?OpenIdConfiguration,

    /// The connector's status.
    status: ?ConnectorStatus,

    /// Information about why connector creation failed, if status is `FAILED`.
    status_reason: ?ConnectorStatusReason,

    /// The connector type.
    @"type": ?ConnectorType,

    /// The date and time that the connector was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .certificate_authority_arn = "CertificateAuthorityArn",
        .created_at = "CreatedAt",
        .endpoint = "Endpoint",
        .mobile_device_management = "MobileDeviceManagement",
        .open_id_configuration = "OpenIdConfiguration",
        .status = "Status",
        .status_reason = "StatusReason",
        .@"type" = "Type",
        .updated_at = "UpdatedAt",
    };
};
