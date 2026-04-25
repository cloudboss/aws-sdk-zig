const OperationUnion = @import("operation_union.zig").OperationUnion;

/// A construct update to apply during a mapping update operation.
pub const StartNetworkMigrationMappingUpdateConstruct = struct {
    /// The ID of the construct to update.
    construct_id: []const u8,

    /// The type of the construct.
    construct_type: []const u8,

    /// The operation to perform on the construct.
    operation: ?OperationUnion = null,

    /// The ID of the segment containing the construct.
    segment_id: []const u8,

    pub const json_field_names = .{
        .construct_id = "constructID",
        .construct_type = "constructType",
        .operation = "operation",
        .segment_id = "segmentID",
    };
};
