const TypeDefinitionFormat = @import("type_definition_format.zig").TypeDefinitionFormat;

/// Describes a type.
pub const Type = struct {
    /// The type Amazon Resource Name (ARN).
    arn: ?[]const u8,

    /// The type definition.
    definition: ?[]const u8,

    /// The type description.
    description: ?[]const u8,

    /// The type format: SDL or JSON.
    format: ?TypeDefinitionFormat,

    /// The type name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .definition = "definition",
        .description = "description",
        .format = "format",
        .name = "name",
    };
};
