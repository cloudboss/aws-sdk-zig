const StatisticsSummary = @import("statistics_summary.zig").StatisticsSummary;

/// Contains statistics information. The DFE engine uses information about the
/// data in your Neptune graph to make effective trade-offs when planning query
/// execution. This information takes the form of statistics that include
/// so-called characteristic sets and predicate statistics that can guide query
/// planning. See [Managing statistics for the Neptune DFE to
/// use](https://docs.aws.amazon.com/neptune/latest/userguide/neptune-dfe-statistics.html).
pub const Statistics = struct {
    /// Indicates whether or not DFE statistics generation is enabled at all.
    active: ?bool,

    /// Indicates whether or not automatic statistics generation is enabled.
    auto_compute: ?bool,

    /// The UTC time at which DFE statistics have most recently been generated.
    date: ?i64,

    /// A note about problems in the case where statistics are invalid.
    note: ?[]const u8,

    /// A StatisticsSummary structure that contains:
    ///
    /// * `signatureCount` - The total number of signatures across all
    ///   characteristic sets.
    /// * `instanceCount` - The total number of characteristic-set instances.
    /// * `predicateCount` - The total number of unique predicates.
    signature_info: ?StatisticsSummary,

    /// Reports the ID of the current statistics generation run. A value of -1
    /// indicates that no statistics have been generated.
    statistics_id: ?[]const u8,

    pub const json_field_names = .{
        .active = "active",
        .auto_compute = "autoCompute",
        .date = "date",
        .note = "note",
        .signature_info = "signatureInfo",
        .statistics_id = "statisticsId",
    };
};
