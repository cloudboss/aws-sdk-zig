const WarmupStatus = @import("warmup_status.zig").WarmupStatus;

/// Contains information about a dedicated IP address that is associated with
/// your Amazon SES
/// account.
///
/// To learn more about requesting dedicated IP addresses, see [Requesting and
/// Relinquishing
/// Dedicated IP
/// Addresses](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/dedicated-ip-case.html) in the *Amazon SES Developer
/// Guide*.
pub const DedicatedIp = struct {
    /// An IPv4 address.
    ip: []const u8,

    /// The name of the dedicated IP pool that the IP address is associated with.
    pool_name: ?[]const u8,

    /// Indicates the progress of your dedicated IP warm-up:
    ///
    /// * `0-100` – For standard dedicated IP addresses, this shows the warm-up
    ///   completion percentage. A value of 100 means the IP address is fully warmed
    ///   up and ready for use.
    ///
    /// * `-1` – Appears for IP addresses in managed dedicated pools where Amazon
    ///   SES automatically handles the warm-up process, making the percentage not
    ///   applicable.
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
    ///
    /// * `NOT_APPLICABLE` – The warm-up status doesn't apply to this IP address.
    /// This status is used for IP addresses in managed dedicated IP pools, where
    /// Amazon SES automatically
    /// handles the warm-up process.
    warmup_status: WarmupStatus,

    pub const json_field_names = .{
        .ip = "Ip",
        .pool_name = "PoolName",
        .warmup_percentage = "WarmupPercentage",
        .warmup_status = "WarmupStatus",
    };
};
