const ItemType = @import("item_type.zig").ItemType;
const ItemValue = @import("item_value.zig").ItemValue;

/// Details and type of a related item.
pub const ItemIdentifier = struct {
    /// The type of related item.
    type: ItemType,

    /// Details about the related item.
    value: ItemValue,

    pub const json_field_names = .{
        .type = "type",
        .value = "value",
    };
};
