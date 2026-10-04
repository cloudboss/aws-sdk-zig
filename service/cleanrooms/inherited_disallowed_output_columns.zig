const ColumnLineageEntry = @import("column_lineage_entry.zig").ColumnLineageEntry;

/// Contains the inherited disallowed output columns constraint and the column
/// lineage tracing each column to its source.
pub const InheritedDisallowedOutputColumns = struct {
    /// The lineage information that traces each disallowed output column back to
    /// its source in a parent table.
    column_lineage: []const ColumnLineageEntry,

    /// The list of column names that are disallowed from appearing in query output,
    /// inherited from parent tables.
    value: []const []const u8,

    pub const json_field_names = .{
        .column_lineage = "columnLineage",
        .value = "value",
    };
};
