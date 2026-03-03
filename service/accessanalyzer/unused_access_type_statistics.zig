/// Contains information about the total number of findings for a type of unused
/// access.
pub const UnusedAccessTypeStatistics = struct {
    /// The total number of findings for the specified unused access type.
    total: ?i32 = null,

    /// The type of unused access.
    unused_access_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .total = "total",
        .unused_access_type = "unusedAccessType",
    };
};
