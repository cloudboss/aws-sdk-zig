const Datum = @import("datum.zig").Datum;

/// The rows that make up a query result table.
pub const Row = struct {
    /// The data that populates a row in a query result table.
    data: ?[]const Datum,

    pub const json_field_names = .{
        .data = "Data",
    };
};
