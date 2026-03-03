const HybridUpdateInfoEntry = @import("hybrid_update_info_entry.zig").HybridUpdateInfoEntry;

/// Contains information about update activities for different components of a
/// hybrid
/// directory.
pub const HybridUpdateActivities = struct {
    /// A list of update activities related to hybrid directory administrator
    /// account
    /// changes.
    hybrid_administrator_account: ?[]const HybridUpdateInfoEntry = null,

    /// A list of update activities related to the self-managed instances with SSM
    /// in the
    /// self-managed instances with SSM hybrid directory configuration.
    self_managed_instances: ?[]const HybridUpdateInfoEntry = null,

    pub const json_field_names = .{
        .hybrid_administrator_account = "HybridAdministratorAccount",
        .self_managed_instances = "SelfManagedInstances",
    };
};
