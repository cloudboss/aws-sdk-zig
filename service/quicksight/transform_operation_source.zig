const DataSetColumnIdMapping = @import("data_set_column_id_mapping.zig").DataSetColumnIdMapping;

/// Specifies the source of data for a transform operation, including the source
/// operation and column mappings.
pub const TransformOperationSource = struct {
    /// The mappings between source column identifiers and target column identifiers
    /// for this transformation.
    column_id_mappings: ?[]const DataSetColumnIdMapping,

    /// The identifier of the transform operation that provides input data.
    transform_operation_id: []const u8,

    pub const json_field_names = .{
        .column_id_mappings = "ColumnIdMappings",
        .transform_operation_id = "TransformOperationId",
    };
};
