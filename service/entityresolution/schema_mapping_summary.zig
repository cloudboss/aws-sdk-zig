/// An object containing `schemaName`, `schemaArn`, `createdAt`, `updatedAt`,
/// and `hasWorkflows`.
pub const SchemaMappingSummary = struct {
    /// The timestamp of when the `SchemaMapping` was created.
    created_at: i64,

    /// Specifies whether the schema mapping has been applied to a workflow.
    has_workflows: bool,

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// `SchemaMapping`.
    schema_arn: []const u8,

    /// The name of the schema.
    schema_name: []const u8,

    /// The timestamp of when the `SchemaMapping` was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .has_workflows = "hasWorkflows",
        .schema_arn = "schemaArn",
        .schema_name = "schemaName",
        .updated_at = "updatedAt",
    };
};
