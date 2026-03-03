const CodegenGenericDataFieldDataType = @import("codegen_generic_data_field_data_type.zig").CodegenGenericDataFieldDataType;
const CodegenGenericDataRelationshipType = @import("codegen_generic_data_relationship_type.zig").CodegenGenericDataRelationshipType;

/// Describes a field in a generic data schema.
pub const CodegenGenericDataField = struct {
    /// The data type for the generic data field.
    data_type: CodegenGenericDataFieldDataType,

    /// The value of the data type for the generic data field.
    data_type_value: []const u8,

    /// Specifies whether the generic data field is an array.
    is_array: bool,

    /// Specifies whether the generic data field is read-only.
    read_only: bool,

    /// The relationship of the generic data schema.
    relationship: ?CodegenGenericDataRelationshipType = null,

    /// Specifies whether the generic data field is required.
    required: bool,

    pub const json_field_names = .{
        .data_type = "dataType",
        .data_type_value = "dataTypeValue",
        .is_array = "isArray",
        .read_only = "readOnly",
        .relationship = "relationship",
        .required = "required",
    };
};
