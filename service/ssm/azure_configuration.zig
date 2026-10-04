const ConfigurationTargets = @import("configuration_targets.zig").ConfigurationTargets;

/// The access details and targets for connecting to a Microsoft Azure tenant,
/// including
/// the application registration used for authentication and the subscriptions
/// to target.
pub const AzureConfiguration = struct {
    /// The display name of the Azure application registration.
    application_display_name: ?[]const u8 = null,

    /// The ID of the Azure application registration used for authentication.
    application_id: []const u8,

    /// The target Azure subscriptions for the cloud connector.
    targets: ?ConfigurationTargets = null,

    /// The display name of the Azure tenant.
    tenant_display_name: ?[]const u8 = null,

    /// The ID of the Azure tenant.
    tenant_id: []const u8,

    pub const json_field_names = .{
        .application_display_name = "ApplicationDisplayName",
        .application_id = "ApplicationId",
        .targets = "Targets",
        .tenant_display_name = "TenantDisplayName",
        .tenant_id = "TenantId",
    };
};
