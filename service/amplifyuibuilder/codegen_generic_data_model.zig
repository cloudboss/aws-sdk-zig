const aws = @import("aws");

const CodegenGenericDataField = @import("codegen_generic_data_field.zig").CodegenGenericDataField;

/// Describes a model in a generic data schema.
pub const CodegenGenericDataModel = struct {
    /// The fields in the generic data model.
    fields: []const aws.map.MapEntry(CodegenGenericDataField),

    /// Specifies whether the generic data model is a join table.
    is_join_table: ?bool = null,

    /// The primary keys of the generic data model.
    primary_keys: []const []const u8,

    pub const json_field_names = .{
        .fields = "fields",
        .is_join_table = "isJoinTable",
        .primary_keys = "primaryKeys",
    };
};
