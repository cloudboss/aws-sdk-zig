const Stats = @import("stats.zig").Stats;

/// Container for the Stats Event.
pub const StatsEvent = struct {
    /// The Stats event details.
    details: ?Stats,
};
