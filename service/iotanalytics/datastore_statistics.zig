const EstimatedResourceSize = @import("estimated_resource_size.zig").EstimatedResourceSize;

/// Statistical information about the data store.
pub const DatastoreStatistics = struct {
    /// The estimated size of the data store.
    size: ?EstimatedResourceSize = null,

    pub const json_field_names = .{
        .size = "size",
    };
};
