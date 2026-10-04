const CustomSql = @import("custom_sql.zig").CustomSql;
const FileSource = @import("file_source.zig").FileSource;
const RelationalTable = @import("relational_table.zig").RelationalTable;
const S3Source = @import("s3_source.zig").S3Source;
const SaaSTable = @import("saa_s_table.zig").SaaSTable;

/// A view of a data source that contains information about the shape of the
/// data in the
/// underlying source. This is a variant type structure. For this structure to
/// be valid,
/// only one of the attributes can be non-null.
pub const PhysicalTable = union(enum) {
    /// A physical table type built from the results of the custom SQL query.
    custom_sql: ?CustomSql,
    /// A physical table type for a file data source.
    file_source: ?FileSource,
    /// A physical table type for relational data sources.
    relational_table: ?RelationalTable,
    /// A physical table type for an S3 data source.
    s3_source: ?S3Source,
    /// A physical table type for Software-as-a-Service (SaaS) sources.
    saa_s_table: ?SaaSTable,

    pub const json_field_names = .{
        .custom_sql = "CustomSql",
        .file_source = "FileSource",
        .relational_table = "RelationalTable",
        .s3_source = "S3Source",
        .saa_s_table = "SaaSTable",
    };
};
