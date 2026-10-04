/// A versioned snapshot of a response edit.
pub const ResponseVersion = struct {
    /// The response text for this version.
    response_text: []const u8,

    /// ISO 8601 timestamp of when this edit was made.
    timestamp: i64,

    pub const json_field_names = .{
        .response_text = "responseText",
        .timestamp = "timestamp",
    };
};
