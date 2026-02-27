const AnalyticsBinByName = @import("analytics_bin_by_name.zig").AnalyticsBinByName;

/// An object containing the criterion by which to bin the results and the value
/// that defines that bin.
pub const AnalyticsBinKey = struct {
    /// The criterion by which to bin the results.
    name: ?AnalyticsBinByName,

    /// The value of the criterion that defines the bin.
    value: ?i64,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
