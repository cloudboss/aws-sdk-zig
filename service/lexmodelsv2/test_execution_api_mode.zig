pub const TestExecutionApiMode = enum {
    streaming,
    non_streaming,

    pub const json_field_names = .{
        .streaming = "Streaming",
        .non_streaming = "NonStreaming",
    };
};
