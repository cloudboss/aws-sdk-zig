const SequenceStoreStatus = @import("sequence_store_status.zig").SequenceStoreStatus;

/// A filter for a sequence store.
pub const SequenceStoreFilter = struct {
    /// The filter's start date.
    created_after: ?i64 = null,

    /// The filter's end date.
    created_before: ?i64 = null,

    /// A name to filter on.
    name: ?[]const u8 = null,

    /// Filter results based on status.
    status: ?SequenceStoreStatus = null,

    /// Filter results based on stores updated after the specified time.
    updated_after: ?i64 = null,

    /// Filter results based on stores updated before the specified time.
    updated_before: ?i64 = null,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .name = "name",
        .status = "status",
        .updated_after = "updatedAfter",
        .updated_before = "updatedBefore",
    };
};
