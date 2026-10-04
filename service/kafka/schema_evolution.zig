/// Configuration controlling whether the Apache Iceberg destination table's
/// schema is evolved as incoming records change.
pub const SchemaEvolution = struct {
    /// Whether to allow MSK to evolve the destination table's schema. Must be false
    /// for the current release.
    enable_schema_evolution: ?bool = null,

    pub const json_field_names = .{
        .enable_schema_evolution = "EnableSchemaEvolution",
    };
};
