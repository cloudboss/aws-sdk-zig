const aws = @import("aws");

const FieldAttributes = @import("field_attributes.zig").FieldAttributes;
const FieldNamespace = @import("field_namespace.zig").FieldNamespace;
const FieldType = @import("field_type.zig").FieldType;

/// Object to store detailed field information.
pub const GetFieldResponse = struct {
    /// Union of field attributes.
    attributes: ?FieldAttributes,

    /// Timestamp at which the resource was created.
    created_time: ?i64,

    /// Denotes whether or not the resource has been deleted.
    deleted: bool = false,

    /// Description of the field.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the field.
    field_arn: []const u8,

    /// Unique identifier of the field.
    field_id: []const u8,

    /// Timestamp at which the resource was created or last modified.
    last_modified_time: ?i64,

    /// Name of the field.
    name: []const u8,

    /// Namespace of the field.
    namespace: FieldNamespace,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// Type of the field.
    type: FieldType,

    pub const json_field_names = .{
        .attributes = "attributes",
        .created_time = "createdTime",
        .deleted = "deleted",
        .description = "description",
        .field_arn = "fieldArn",
        .field_id = "fieldId",
        .last_modified_time = "lastModifiedTime",
        .name = "name",
        .namespace = "namespace",
        .tags = "tags",
        .type = "type",
    };
};
