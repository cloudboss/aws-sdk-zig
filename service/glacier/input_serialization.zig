const CSVInput = @import("csv_input.zig").CSVInput;

/// Describes how the archive is serialized.
pub const InputSerialization = struct {
    /// Describes the serialization of a CSV-encoded object.
    csv: ?CSVInput,

    pub const json_field_names = .{
        .csv = "csv",
    };
};
