const FieldAttributes = @import("field_attributes.zig").FieldAttributes;
const FieldNamespace = @import("field_namespace.zig").FieldNamespace;
const FieldType = @import("field_type.zig").FieldType;

/// Object for the summarized details of the field.
pub const FieldSummary = struct {
    /// Union of field attributes.
    attributes: ?FieldAttributes,

    /// The Amazon Resource Name (ARN) of the field.
    field_arn: []const u8,

    /// The unique identifier of a field.
    field_id: []const u8,

    /// Name of the field.
    name: []const u8,

    /// The namespace of a field.
    namespace: FieldNamespace,

    /// The type of a field.
    type: FieldType,

    pub const json_field_names = .{
        .attributes = "attributes",
        .field_arn = "fieldArn",
        .field_id = "fieldId",
        .name = "name",
        .namespace = "namespace",
        .type = "type",
    };
};
