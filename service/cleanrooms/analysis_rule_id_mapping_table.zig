const QueryConstraint = @import("query_constraint.zig").QueryConstraint;

/// Defines details for the analysis rule ID mapping table.
pub const AnalysisRuleIdMappingTable = struct {
    /// The columns that query runners are allowed to select, group by, or filter
    /// by.
    dimension_columns: ?[]const []const u8 = null,

    /// The columns that query runners are allowed to use in an INNER JOIN
    /// statement.
    join_columns: []const []const u8,

    /// The query constraints of the analysis rule ID mapping table.
    query_constraints: []const QueryConstraint,

    pub const json_field_names = .{
        .dimension_columns = "dimensionColumns",
        .join_columns = "joinColumns",
        .query_constraints = "queryConstraints",
    };
};
