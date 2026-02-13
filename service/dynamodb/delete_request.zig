const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// Represents a request to perform a `DeleteItem` operation on an item.
pub const DeleteRequest = struct {
    /// A map of attribute name to attribute values, representing the primary key of
    /// the item
    /// to delete. All of the table's primary key attributes must be specified, and
    /// their data
    /// types must match those of the table's key schema.
    key: []const aws.map.MapEntry(AttributeValue),

    pub const json_field_names = .{
        .key = "Key",
    };
};
