/// The possible states of a cluster alert. SET - The alert is actively
/// happening. CLEARED - The alert is no longer happening.
pub const ClusterAlertState = enum {
    set,
    cleared,

    pub const json_field_names = .{
        .set = "SET",
        .cleared = "CLEARED",
    };
};
