const ModelMetadataFilterType = @import("model_metadata_filter_type.zig").ModelMetadataFilterType;

/// Part of the search expression. You can specify the name and value (domain,
/// task, framework, framework version, task, and model).
pub const ModelMetadataFilter = struct {
    /// The name of the of the model to filter by.
    name: ModelMetadataFilterType,

    /// The value to filter the model metadata.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
