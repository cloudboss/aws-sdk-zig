const SpanMessageValue = @import("span_message_value.zig").SpanMessageValue;

/// Tool result message content
pub const SpanToolResultValue = struct {
    /// The tool invocation error if failed
    @"error": ?[]const u8,

    /// Relates this result back to the tool invocation
    tool_use_id: []const u8,

    /// The tool results
    values: []const SpanMessageValue,

    pub const json_field_names = .{
        .@"error" = "error",
        .tool_use_id = "toolUseId",
        .values = "values",
    };
};
