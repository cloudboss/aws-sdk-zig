const AthenaTableReference = @import("athena_table_reference.zig").AthenaTableReference;
const GlueTableReference = @import("glue_table_reference.zig").GlueTableReference;
const SnowflakeTableReference = @import("snowflake_table_reference.zig").SnowflakeTableReference;

/// A pointer to the dataset that underlies this table.
pub const TableReference = union(enum) {
    /// If present, a reference to the Athena table referred to by this table
    /// reference.
    athena: ?AthenaTableReference,
    /// If present, a reference to the Glue table referred to by this table
    /// reference.
    glue: ?GlueTableReference,
    /// If present, a reference to the Snowflake table referred to by this table
    /// reference.
    snowflake: ?SnowflakeTableReference,

    pub const json_field_names = .{
        .athena = "athena",
        .glue = "glue",
        .snowflake = "snowflake",
    };
};
