const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// Details for the requested item.
pub const ItemResponse = struct {
    /// Map of attribute data consisting of the data type and attribute value.
    item: ?[]const aws.map.MapEntry(AttributeValue),

    pub const json_field_names = .{
        .item = "Item",
    };
};
