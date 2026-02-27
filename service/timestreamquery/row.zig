const Datum = @import("datum.zig").Datum;

/// Represents a single row in the query results.
pub const Row = struct {
    /// List of data points in a single row of the result set.
    data: []const Datum,

    pub const json_field_names = .{
        .data = "Data",
    };
};
