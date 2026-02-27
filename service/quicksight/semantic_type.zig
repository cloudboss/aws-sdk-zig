const aws = @import("aws");

/// A structure that represents a semantic type.
pub const SemanticType = struct {
    /// The semantic type falsey cell value.
    falsey_cell_value: ?[]const u8,

    /// The other names or aliases for the false cell value.
    falsey_cell_value_synonyms: ?[]const []const u8,

    /// The semantic type sub type name.
    sub_type_name: ?[]const u8,

    /// The semantic type truthy cell value.
    truthy_cell_value: ?[]const u8,

    /// The other names or aliases for the true cell value.
    truthy_cell_value_synonyms: ?[]const []const u8,

    /// The semantic type name.
    type_name: ?[]const u8,

    /// The semantic type parameters.
    type_parameters: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .falsey_cell_value = "FalseyCellValue",
        .falsey_cell_value_synonyms = "FalseyCellValueSynonyms",
        .sub_type_name = "SubTypeName",
        .truthy_cell_value = "TruthyCellValue",
        .truthy_cell_value_synonyms = "TruthyCellValueSynonyms",
        .type_name = "TypeName",
        .type_parameters = "TypeParameters",
    };
};
