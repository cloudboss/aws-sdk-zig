const LimitlessDatabaseStatus = @import("limitless_database_status.zig").LimitlessDatabaseStatus;

/// Contains details for Aurora Limitless Database.
pub const LimitlessDatabase = struct {
    /// The minimum required capacity for Aurora Limitless Database in Aurora
    /// capacity units (ACUs).
    min_required_acu: ?f64 = null,

    /// The status of Aurora Limitless Database.
    status: ?LimitlessDatabaseStatus = null,
};
