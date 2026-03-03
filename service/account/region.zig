const RegionOptStatus = @import("region_opt_status.zig").RegionOptStatus;

/// This is a structure that expresses the Region for a given account,
/// consisting of a name and opt-in status.
pub const Region = struct {
    /// The Region code of a given Region (for example, `us-east-1`).
    region_name: ?[]const u8 = null,

    /// One of potential statuses a Region can undergo (Enabled, Enabling, Disabled,
    /// Disabling, Enabled_By_Default).
    region_opt_status: ?RegionOptStatus = null,

    pub const json_field_names = .{
        .region_name = "RegionName",
        .region_opt_status = "RegionOptStatus",
    };
};
