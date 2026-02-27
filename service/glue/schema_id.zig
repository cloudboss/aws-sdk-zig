/// The unique ID of the schema in the Glue schema registry.
pub const SchemaId = struct {
    /// The name of the schema registry that contains the schema.
    registry_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the schema. One of `SchemaArn` or
    /// `SchemaName` has to be provided.
    schema_arn: ?[]const u8,

    /// The name of the schema. One of `SchemaArn` or `SchemaName` has to be
    /// provided.
    schema_name: ?[]const u8,

    pub const json_field_names = .{
        .registry_name = "RegistryName",
        .schema_arn = "SchemaArn",
        .schema_name = "SchemaName",
    };
};
