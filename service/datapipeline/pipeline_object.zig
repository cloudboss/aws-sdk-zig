const Field = @import("field.zig").Field;

/// Contains information about a pipeline object. This can be a logical,
/// physical, or physical attempt pipeline object. The complete set of
/// components of a pipeline defines the pipeline.
pub const PipelineObject = struct {
    /// Key-value pairs that define the properties of the object.
    fields: []const Field,

    /// The ID of the object.
    id: []const u8,

    /// The name of the object.
    name: []const u8,

    pub const json_field_names = .{
        .fields = "fields",
        .id = "id",
        .name = "name",
    };
};
