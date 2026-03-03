const CSVOutput = @import("csv_output.zig").CSVOutput;
const JSONOutput = @import("json_output.zig").JSONOutput;

/// Describes how results of the Select job are serialized.
pub const OutputSerialization = struct {
    /// Describes the serialization of CSV-encoded Select results.
    csv: ?CSVOutput = null,

    /// Specifies JSON as request's output serialization format.
    json: ?JSONOutput = null,
};
