const IncrementalRefresh = @import("incremental_refresh.zig").IncrementalRefresh;

/// The refresh configuration of a dataset.
pub const RefreshConfiguration = struct {
    /// The incremental refresh for the dataset.
    incremental_refresh: IncrementalRefresh,

    pub const json_field_names = .{
        .incremental_refresh = "IncrementalRefresh",
    };
};
