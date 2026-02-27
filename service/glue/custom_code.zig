const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a transform that uses custom code you provide to perform the data
/// transformation. The output is a collection of DynamicFrames.
pub const CustomCode = struct {
    /// The name defined for the custom code node class.
    class_name: []const u8,

    /// The custom code that is used to perform the data transformation.
    code: []const u8,

    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    /// Specifies the data schema for the custom code transform.
    output_schemas: ?[]const GlueSchema,

    pub const json_field_names = .{
        .class_name = "ClassName",
        .code = "Code",
        .inputs = "Inputs",
        .name = "Name",
        .output_schemas = "OutputSchemas",
    };
};
