const DatabaseLFTagPolicy = @import("database_lf_tag_policy.zig").DatabaseLFTagPolicy;
const TableLFTagPolicy = @import("table_lf_tag_policy.zig").TableLFTagPolicy;

/// Details about the AWS Lake Formation resource (Table or Database) included
/// in the AWS Lake Formation data permission.
pub const LFResourceDetails = struct {
    /// Details about the database resource included in the AWS Lake Formation data
    /// permission.
    database: ?DatabaseLFTagPolicy = null,

    /// Details about the table resource included in the AWS Lake Formation data
    /// permission.
    table: ?TableLFTagPolicy = null,

    pub const json_field_names = .{
        .database = "Database",
        .table = "Table",
    };
};
