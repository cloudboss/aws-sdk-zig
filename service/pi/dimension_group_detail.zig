const DimensionDetail = @import("dimension_detail.zig").DimensionDetail;

/// Information about dimensions within a dimension group.
pub const DimensionGroupDetail = struct {
    /// The dimensions within a dimension group.
    dimensions: ?[]const DimensionDetail,

    /// The name of the dimension group.
    group: ?[]const u8,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .group = "Group",
    };
};
