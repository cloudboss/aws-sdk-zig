const LifeCycleLastCutover = @import("life_cycle_last_cutover.zig").LifeCycleLastCutover;
const LifeCycleLastTest = @import("life_cycle_last_test.zig").LifeCycleLastTest;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

/// Lifecycle.
pub const LifeCycle = struct {
    /// Lifecycle added to service data and time.
    added_to_service_date_time: ?[]const u8,

    /// Lifecycle elapsed time and duration.
    elapsed_replication_duration: ?[]const u8,

    /// Lifecycle replication initiation date and time.
    first_byte_date_time: ?[]const u8,

    /// Lifecycle last Cutover.
    last_cutover: ?LifeCycleLastCutover,

    /// Lifecycle last seen date and time.
    last_seen_by_service_date_time: ?[]const u8,

    /// Lifecycle last Test.
    last_test: ?LifeCycleLastTest,

    /// Lifecycle state.
    state: ?LifeCycleState,

    pub const json_field_names = .{
        .added_to_service_date_time = "addedToServiceDateTime",
        .elapsed_replication_duration = "elapsedReplicationDuration",
        .first_byte_date_time = "firstByteDateTime",
        .last_cutover = "lastCutover",
        .last_seen_by_service_date_time = "lastSeenByServiceDateTime",
        .last_test = "lastTest",
        .state = "state",
    };
};
