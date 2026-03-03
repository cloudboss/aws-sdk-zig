const KeyValueStoreAssociation = @import("key_value_store_association.zig").KeyValueStoreAssociation;

/// The key value store associations.
pub const KeyValueStoreAssociations = struct {
    /// The items of the key value store association.
    items: ?[]const KeyValueStoreAssociation = null,

    /// The quantity of key value store associations.
    quantity: i32,
};
