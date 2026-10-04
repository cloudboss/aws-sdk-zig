const CloneType = @import("clone_type.zig").CloneType;
const OpenMode = @import("open_mode.zig").OpenMode;
const RefreshableMode = @import("refreshable_mode.zig").RefreshableMode;

/// The configuration for creating an Autonomous Database as a refreshable
/// clone.
pub const CloneToRefreshableConfiguration = struct {
    /// The frequency, in seconds, at which the refreshable clone is automatically
    /// refreshed.
    auto_refresh_frequency_in_seconds: ?i32 = null,

    /// The time lag, in seconds, between the refreshable clone and its source
    /// database.
    auto_refresh_point_lag_in_seconds: ?i32 = null,

    /// The type of clone to create.
    clone_type: ?CloneType = null,

    /// The mode in which to open the refreshable clone, either read-only or
    /// read/write.
    open_mode: ?OpenMode = null,

    /// The refresh mode of the refreshable clone, either automatic or manual.
    refreshable_mode: ?RefreshableMode = null,

    /// The unique identifier of the source Autonomous Database to create the
    /// refreshable clone from.
    source_autonomous_database_id: []const u8,

    /// The date and time at which the automatic refresh of the refreshable clone
    /// starts.
    time_of_auto_refresh_start: ?i64 = null,

    pub const json_field_names = .{
        .auto_refresh_frequency_in_seconds = "autoRefreshFrequencyInSeconds",
        .auto_refresh_point_lag_in_seconds = "autoRefreshPointLagInSeconds",
        .clone_type = "cloneType",
        .open_mode = "openMode",
        .refreshable_mode = "refreshableMode",
        .source_autonomous_database_id = "sourceAutonomousDatabaseId",
        .time_of_auto_refresh_start = "timeOfAutoRefreshStart",
    };
};
