/// Status information for a specific region.
pub const RegionStatus = struct {
    /// Status value for the region.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
