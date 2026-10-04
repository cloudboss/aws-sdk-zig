const ScopeType = @import("scope_type.zig").ScopeType;
const ScopeState = @import("scope_state.zig").ScopeState;

/// The scope of resources that Amazon Inspector scans for a single scanning
/// type, including the scope level, the targeted resources, and the current
/// state.
pub const ScopeConfiguration = struct {
    /// The type of scope. Valid values are `TENANT`, which scans all resources in
    /// the Azure tenant, and `SUBSCRIPTION`, which scans only the resources in the
    /// specified Azure subscriptions.
    scope_type: ScopeType,

    /// The list of scope values. For subscription-level scope, these are Azure
    /// subscription IDs.
    scope_values: ?[]const []const u8 = null,

    /// The current state of the scope configuration.
    state: ?ScopeState = null,

    /// The reason for the current state of the scope configuration.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .scope_type = "scopeType",
        .scope_values = "scopeValues",
        .state = "state",
        .state_reason = "stateReason",
    };
};
