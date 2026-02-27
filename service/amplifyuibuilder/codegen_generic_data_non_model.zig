const aws = @import("aws");

const CodegenGenericDataField = @import("codegen_generic_data_field.zig").CodegenGenericDataField;

/// Describes a non-model in a generic data schema.
pub const CodegenGenericDataNonModel = struct {
    /// The fields in a generic data schema non model.
    fields: []const aws.map.MapEntry(CodegenGenericDataField),

    pub const json_field_names = .{
        .fields = "fields",
    };
};
