const TieringPolicyName = @import("tiering_policy_name.zig").TieringPolicyName;

/// Describes the data tiering policy for an ONTAP volume. When enabled, Amazon
/// FSx for ONTAP's intelligent
/// tiering automatically transitions a volume's data between the file system's
/// primary storage and capacity
/// pool storage based on your access patterns.
///
/// Valid tiering policies are the following:
///
/// * `SNAPSHOT_ONLY` - (Default value) moves cold snapshots to the capacity
///   pool storage tier.
///
/// * `AUTO` - moves cold user data and snapshots to the capacity pool storage
///   tier based on your access patterns.
///
/// * `ALL` - moves all user data blocks in both the active file system and
///   Snapshot copies to the storage pool tier.
///
/// * `NONE` - keeps a volume's data in the primary storage tier, preventing it
///   from being moved to the capacity pool tier.
pub const TieringPolicy = struct {
    /// Specifies the number of days that user data in a volume must remain inactive
    /// before it is considered "cold"
    /// and moved to the capacity pool. Used with the `AUTO` and `SNAPSHOT_ONLY`
    /// tiering policies.
    /// Enter a whole number between 2 and 183. Default values are 31 days for
    /// `AUTO` and 2 days for
    /// `SNAPSHOT_ONLY`.
    cooling_period: ?i32,

    /// Specifies the tiering policy used to transition data. Default value is
    /// `SNAPSHOT_ONLY`.
    ///
    /// * `SNAPSHOT_ONLY` - moves cold snapshots to the capacity pool storage tier.
    ///
    /// * `AUTO` - moves cold user data and snapshots to the capacity pool storage
    ///   tier
    /// based on your access patterns.
    ///
    /// * `ALL` - moves all user data blocks in both the active file system and
    ///   Snapshot copies to the
    /// storage pool tier.
    ///
    /// * `NONE` - keeps a volume's data in the primary storage tier, preventing it
    ///   from being moved to
    /// the capacity pool tier.
    name: ?TieringPolicyName,

    pub const json_field_names = .{
        .cooling_period = "CoolingPeriod",
        .name = "Name",
    };
};
