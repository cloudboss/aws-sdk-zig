const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;
const ReplicationType = @import("replication_type.zig").ReplicationType;

/// Request to filter Source Servers list.
pub const DescribeSourceServersRequestFilters = struct {
    /// Request to filter Source Servers list by application IDs.
    application_i_ds: ?[]const []const u8,

    /// Request to filter Source Servers list by archived.
    is_archived: ?bool,

    /// Request to filter Source Servers list by life cycle states.
    life_cycle_states: ?[]const LifeCycleState,

    /// Request to filter Source Servers list by replication type.
    replication_types: ?[]const ReplicationType,

    /// Request to filter Source Servers list by Source Server ID.
    source_server_i_ds: ?[]const []const u8,

    pub const json_field_names = .{
        .application_i_ds = "applicationIDs",
        .is_archived = "isArchived",
        .life_cycle_states = "lifeCycleStates",
        .replication_types = "replicationTypes",
        .source_server_i_ds = "sourceServerIDs",
    };
};
