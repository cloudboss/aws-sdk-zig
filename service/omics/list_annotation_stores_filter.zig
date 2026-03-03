const StoreStatus = @import("store_status.zig").StoreStatus;

/// A filter for annotation stores.
pub const ListAnnotationStoresFilter = struct {
    /// A status to filter on.
    status: ?StoreStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
