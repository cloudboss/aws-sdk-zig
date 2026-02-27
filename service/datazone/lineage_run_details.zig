const LineageSqlQueryRunDetails = @import("lineage_sql_query_run_details.zig").LineageSqlQueryRunDetails;

/// The data lineage run details.
pub const LineageRunDetails = struct {
    /// The SQL query run details of a data lineage run.
    sql_query_run_details: ?LineageSqlQueryRunDetails,

    pub const json_field_names = .{
        .sql_query_run_details = "sqlQueryRunDetails",
    };
};
