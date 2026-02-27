const AttackVolumeStatistics = @import("attack_volume_statistics.zig").AttackVolumeStatistics;

/// Information about the volume of attacks during the time period, included in
/// an AttackStatisticsDataItem. If the accompanying `AttackCount` in the
/// statistics object is zero, this setting might be empty.
pub const AttackVolume = struct {
    /// A statistics object that uses bits per second as the unit. This is included
    /// for network level attacks.
    bits_per_second: ?AttackVolumeStatistics,

    /// A statistics object that uses packets per second as the unit. This is
    /// included for network level attacks.
    packets_per_second: ?AttackVolumeStatistics,

    /// A statistics object that uses requests per second as the unit. This is
    /// included for application level attacks, and is only available for accounts
    /// that are subscribed to Shield Advanced.
    requests_per_second: ?AttackVolumeStatistics,

    pub const json_field_names = .{
        .bits_per_second = "BitsPerSecond",
        .packets_per_second = "PacketsPerSecond",
        .requests_per_second = "RequestsPerSecond",
    };
};
