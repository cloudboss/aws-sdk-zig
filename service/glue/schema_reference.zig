const SchemaId = @import("schema_id.zig").SchemaId;

/// An object that references a schema stored in the Glue Schema Registry.
pub const SchemaReference = struct {
    /// A structure that contains schema identity fields. Either this or the
    /// `SchemaVersionId` has to be provided.
    schema_id: ?SchemaId = null,

    /// The unique ID assigned to a version of the schema. Either this or the
    /// `SchemaId` has to be provided.
    schema_version_id: ?[]const u8 = null,

    /// The version number of the schema.
    schema_version_number: ?i64 = null,

    pub const json_field_names = .{
        .schema_id = "SchemaId",
        .schema_version_id = "SchemaVersionId",
        .schema_version_number = "SchemaVersionNumber",
    };
};
