const StorageConnectorType = @import("storage_connector_type.zig").StorageConnectorType;

/// Describes a connector that enables persistent storage for users.
pub const StorageConnector = struct {
    /// The type of storage connector.
    connector_type: StorageConnectorType,

    /// The names of the domains for the account.
    domains: ?[]const []const u8 = null,

    /// The OneDrive for Business domains where you require admin consent when users
    /// try to link their OneDrive account to WorkSpaces Applications. The attribute
    /// can only be specified when ConnectorType=ONE_DRIVE.
    domains_require_admin_consent: ?[]const []const u8 = null,

    /// The ARN of the storage connector.
    resource_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_type = "ConnectorType",
        .domains = "Domains",
        .domains_require_admin_consent = "DomainsRequireAdminConsent",
        .resource_identifier = "ResourceIdentifier",
    };
};
