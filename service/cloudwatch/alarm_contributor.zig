const aws = @import("aws");

/// Represents an individual contributor to a multi-timeseries alarm, containing
/// information about a specific time series and its contribution to the alarm's
/// state.
pub const AlarmContributor = struct {
    /// A map of attributes that describe the contributor, such as metric dimensions
    /// and other identifying characteristics.
    contributor_attributes: []const aws.map.StringMapEntry,

    /// The unique identifier for this alarm contributor.
    contributor_id: []const u8,

    /// An explanation for the contributor's current state, providing context about
    /// why it is in its current condition.
    state_reason: []const u8,

    /// The timestamp when the contributor last transitioned to its current state.
    state_transitioned_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .contributor_attributes = "ContributorAttributes",
        .contributor_id = "ContributorId",
        .state_reason = "StateReason",
        .state_transitioned_timestamp = "StateTransitionedTimestamp",
    };
};
