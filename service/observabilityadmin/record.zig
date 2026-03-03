const RecordFormat = @import("record_format.zig").RecordFormat;

/// Represents a test record structure used for pipeline testing operations to
/// validate data processing.
pub const Record = struct {
    /// The data content of the test record used for pipeline validation.
    data: ?[]const u8 = null,

    /// The type of the test record, indicating the format or category of the data.
    @"type": ?RecordFormat = null,

    pub const json_field_names = .{
        .data = "Data",
        .@"type" = "Type",
    };
};
