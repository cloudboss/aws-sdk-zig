const aws = @import("aws");

/// A structure that represents a semantic entity type.
pub const SemanticEntityType = struct {
    /// The semantic entity sub type name.
    sub_type_name: ?[]const u8 = null,

    /// The semantic entity type name.
    type_name: ?[]const u8 = null,

    /// The semantic entity type parameters.
    type_parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .sub_type_name = "SubTypeName",
        .type_name = "TypeName",
        .type_parameters = "TypeParameters",
    };
};
