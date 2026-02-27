const FailoverMode = @import("failover_mode.zig").FailoverMode;
const SourcePriority = @import("source_priority.zig").SourcePriority;
const State = @import("state.zig").State;

/// The settings for source failover.
pub const FailoverConfig = struct {
    /// The type of failover you choose for this flow. MERGE combines the source
    /// streams into a single stream, allowing graceful recovery from any
    /// single-source loss. FAILOVER allows switching between different streams.
    failover_mode: ?FailoverMode,

    /// Search window time to look for dash-7 packets.
    recovery_window: ?i32,

    /// The priority you want to assign to a source. You can have a primary stream
    /// and a backup stream or two equally prioritized streams.
    source_priority: ?SourcePriority,

    /// The state of source failover on the flow. If the state is inactive, the flow
    /// can have only one source. If the state is active, the flow can have one or
    /// two sources.
    state: ?State,

    pub const json_field_names = .{
        .failover_mode = "FailoverMode",
        .recovery_window = "RecoveryWindow",
        .source_priority = "SourcePriority",
        .state = "State",
    };
};
