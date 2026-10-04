const ScopeType = @import("scope_type.zig").ScopeType;

/// The scope of resources to scan for a single scanning type. Provide this as
/// part of an `AzureScopeConfigurationInput` when you create or update a
/// connector.
pub const ScopeConfigurationInput = struct {
    /// The type of scope. Valid values are `TENANT`, which scans all resources in
    /// the Azure tenant, and `SUBSCRIPTION`, which scans only the resources in the
    /// specified Azure subscriptions.
    scope_type: ScopeType,

    /// The list of scope values. For subscription-level scope, these are Azure
    /// subscription IDs.
    scope_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .scope_type = "scopeType",
        .scope_values = "scopeValues",
    };
};
