const WarmupStatus = @import("warmup_status.zig").WarmupStatus;

/// Contains information about a dedicated IP address that is associated with
/// your Amazon Pinpoint
/// account.
pub const DedicatedIp = struct {
    /// An IP address that is reserved for use by your Amazon Pinpoint account.
    ip: []const u8,

    /// The name of the dedicated IP pool that the IP address is associated with.
    pool_name: ?[]const u8 = null,

    /// Indicates how complete the dedicated IP warm-up process is. When this value
    /// equals 1,
    /// the address has completed the warm-up process and is ready for use.
    warmup_percentage: i32,

    /// The warm-up status of a dedicated IP address. The status can have one of the
    /// following
    /// values:
    ///
    /// * `IN_PROGRESS` – The IP address isn't ready to use because the
    /// dedicated IP warm-up process is ongoing.
    ///
    /// * `DONE` – The dedicated IP warm-up process is complete, and
    /// the IP address is ready to use.
    warmup_status: WarmupStatus,

    pub const json_field_names = .{
        .ip = "Ip",
        .pool_name = "PoolName",
        .warmup_percentage = "WarmupPercentage",
        .warmup_status = "WarmupStatus",
    };
};
