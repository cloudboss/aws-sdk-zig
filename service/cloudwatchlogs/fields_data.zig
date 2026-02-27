/// A structure containing the extracted fields from a log event. These fields
/// are extracted
/// based on the log format and can be used for structured querying and
/// analysis.
pub const FieldsData = struct {
    /// The actual log data content returned in the streaming response. This
    /// contains the fields
    /// and values of the log event in a structured format that can be parsed and
    /// processed by the
    /// client.
    data: ?[]const u8,

    pub const json_field_names = .{
        .data = "data",
    };
};
