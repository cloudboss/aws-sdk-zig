const StoreStatus = @import("store_status.zig").StoreStatus;

/// A filter for variant stores.
pub const ListVariantStoresFilter = struct {
    /// A status to filter on.
    status: ?StoreStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
