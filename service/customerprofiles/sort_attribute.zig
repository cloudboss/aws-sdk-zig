const SegmentSortDataType = @import("segment_sort_data_type.zig").SegmentSortDataType;
const SegmentSortOrder = @import("segment_sort_order.zig").SegmentSortOrder;
const SortAttributeType = @import("sort_attribute_type.zig").SortAttributeType;

/// Defines the characteristics and rules for sorting by a specific attribute.
pub const SortAttribute = struct {
    /// The data type of the sort attribute (e.g., string, number, date).
    data_type: ?SegmentSortDataType = null,

    /// The name of the attribute to sort by.
    name: []const u8,

    /// The sort order for the attribute (ascending or descending).
    order: SegmentSortOrder,

    /// The type of attribute (e.g., profile, calculated).
    @"type": SortAttributeType = .profile,

    pub const json_field_names = .{
        .data_type = "DataType",
        .name = "Name",
        .order = "Order",
        .@"type" = "Type",
    };
};
