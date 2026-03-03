/// Request payload part structure.
pub const RequestPayloadPart = struct {
    /// The payload bytes.
    bytes: ?[]const u8 = null,

    /// Completion state header. Can be one of these possible values: "PARTIAL",
    /// "COMPLETE".
    completion_state: ?[]const u8 = null,

    /// Data type header. Can be one of these possible values: "UTF8", "BINARY".
    data_type: ?[]const u8 = null,

    /// Padding string for alignment.
    p: ?[]const u8 = null,

    pub const json_field_names = .{
        .bytes = "Bytes",
        .completion_state = "CompletionState",
        .data_type = "DataType",
        .p = "P",
    };
};
