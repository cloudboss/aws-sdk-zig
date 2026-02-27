const CSVOutput = @import("csv_output.zig").CSVOutput;

/// Describes how the select output is serialized.
pub const OutputSerialization = struct {
    /// Describes the serialization of CSV-encoded query results.
    csv: ?CSVOutput,

    pub const json_field_names = .{
        .csv = "csv",
    };
};
