const KeyValueStore = @import("key_value_store.zig").KeyValueStore;

/// The key value store list.
pub const KeyValueStoreList = struct {
    /// The items of the key value store list.
    items: ?[]const KeyValueStore = null,

    /// The maximum number of items in the key value store list.
    max_items: i32,

    /// The next marker associated with the key value store list.
    next_marker: ?[]const u8 = null,

    /// The quantity of the key value store list.
    quantity: i32,
};
