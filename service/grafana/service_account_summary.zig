const Role = @import("role.zig").Role;

/// A structure that contains the information about one service account.
pub const ServiceAccountSummary = struct {
    /// The role of the service account, which sets the permission level used when
    /// calling
    /// Grafana APIs.
    grafana_role: Role,

    /// The unique ID of the service account.
    id: []const u8,

    /// Returns true if the service account is disabled. Service accounts can be
    /// disabled and
    /// enabled in the Amazon Managed Grafana console.
    is_disabled: []const u8,

    /// The name of the service account.
    name: []const u8,

    pub const json_field_names = .{
        .grafana_role = "grafanaRole",
        .id = "id",
        .is_disabled = "isDisabled",
        .name = "name",
    };
};
