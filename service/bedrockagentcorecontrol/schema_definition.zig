const aws = @import("aws");

const SchemaType = @import("schema_type.zig").SchemaType;

/// A schema definition for a gateway target. This structure defines the
/// structure of the API that the target exposes.
pub const SchemaDefinition = struct {
    /// The description of the schema definition. This description provides
    /// information about the purpose and usage of the schema.
    description: ?[]const u8,

    /// The items in the schema definition. This field is used for array types to
    /// define the structure of the array elements.
    items: ?*SchemaDefinition = null,

    /// The properties of the schema definition. These properties define the fields
    /// in the schema.
    properties: ?[]const aws.map.MapEntry(SchemaDefinition),

    /// The required fields in the schema definition. These fields must be provided
    /// when using the schema.
    required: ?[]const []const u8,

    /// The type of the schema definition. This field specifies the data type of the
    /// schema.
    @"type": SchemaType,

    pub const json_field_names = .{
        .description = "description",
        .items = "items",
        .properties = "properties",
        .required = "required",
        .@"type" = "type",
    };
};
