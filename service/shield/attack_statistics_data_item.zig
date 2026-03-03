const AttackVolume = @import("attack_volume.zig").AttackVolume;

/// A single attack statistics data record. This is returned by
/// DescribeAttackStatistics along with a time range indicating the time period
/// that the attack statistics apply to.
pub const AttackStatisticsDataItem = struct {
    /// The number of attacks detected during the time period. This is always
    /// present, but might be zero.
    attack_count: i64 = 0,

    /// Information about the volume of attacks during the time period. If the
    /// accompanying `AttackCount` is zero, this setting might be empty.
    attack_volume: ?AttackVolume = null,

    pub const json_field_names = .{
        .attack_count = "AttackCount",
        .attack_volume = "AttackVolume",
    };
};
