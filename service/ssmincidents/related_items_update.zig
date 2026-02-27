const RelatedItem = @import("related_item.zig").RelatedItem;
const ItemIdentifier = @import("item_identifier.zig").ItemIdentifier;

/// Details about the related item you're adding.
pub const RelatedItemsUpdate = union(enum) {
    /// Details about the related item you're adding.
    item_to_add: ?RelatedItem,
    /// Details about the related item you're deleting.
    item_to_remove: ?ItemIdentifier,

    pub const json_field_names = .{
        .item_to_add = "itemToAdd",
        .item_to_remove = "itemToRemove",
    };
};
