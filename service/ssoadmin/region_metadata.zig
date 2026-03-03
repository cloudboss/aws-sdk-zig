const RegionStatus = @import("region_status.zig").RegionStatus;

/// Contains information about an enabled Region of an IAM Identity Center
/// instance, including the Region name, status, date added, and whether it is
/// the primary Region.
pub const RegionMetadata = struct {
    /// The timestamp when the Region was added to the IAM Identity Center instance.
    /// For the primary Region, this is the instance creation time.
    added_date: ?i64 = null,

    /// Indicates whether this is the primary Region where the IAM Identity Center
    /// instance was originally enabled. The primary Region cannot be removed.
    is_primary_region: bool = false,

    /// The Amazon Web Services Region name.
    region_name: ?[]const u8 = null,

    /// The current status of the Region. Valid values are ACTIVE (Region is
    /// operational), ADDING (Region extension workflow is in progress), or REMOVING
    /// (Region removal workflow is in progress).
    status: ?RegionStatus = null,

    pub const json_field_names = .{
        .added_date = "AddedDate",
        .is_primary_region = "IsPrimaryRegion",
        .region_name = "RegionName",
        .status = "Status",
    };
};
