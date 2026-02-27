const ResultRow = @import("result_row.zig").ResultRow;

/// Provides the results of a query that retrieved the data for a standard
/// metric that applies to an application, campaign, or journey.
pub const BaseKpiResult = struct {
    /// An array of objects that provides the results of a query that retrieved the
    /// data for a standard metric that applies to an application, campaign, or
    /// journey.
    rows: []const ResultRow,

    pub const json_field_names = .{
        .rows = "Rows",
    };
};
