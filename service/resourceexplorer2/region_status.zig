const IndexStatus = @import("index_status.zig").IndexStatus;
const ViewStatus = @import("view_status.zig").ViewStatus;

/// Contains information about the status of Resource Explorer configuration in
/// a specific Amazon Web Services Region.
pub const RegionStatus = struct {
    /// The status information for the Resource Explorer index in this Region.
    index: ?IndexStatus,

    /// The Amazon Web Services Region for which this status information applies.
    region: ?[]const u8,

    /// The status information for the Resource Explorer view in this Region.
    view: ?ViewStatus,

    pub const json_field_names = .{
        .index = "Index",
        .region = "Region",
        .view = "View",
    };
};
