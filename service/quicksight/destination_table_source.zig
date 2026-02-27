/// Specifies the source of data for a destination table, including the
/// transform operation and column mappings.
pub const DestinationTableSource = struct {
    /// The identifier of the transform operation that provides data to the
    /// destination table.
    transform_operation_id: []const u8,

    pub const json_field_names = .{
        .transform_operation_id = "TransformOperationId",
    };
};
