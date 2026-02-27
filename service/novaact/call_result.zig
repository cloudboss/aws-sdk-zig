const CallResultContent = @import("call_result_content.zig").CallResultContent;

/// The result returned from executing a tool call.
pub const CallResult = struct {
    /// The identifier of the tool call that this result corresponds to.
    call_id: ?[]const u8,

    /// The content returned by the tool execution, which can include text or other
    /// media types.
    content: []const CallResultContent,

    pub const json_field_names = .{
        .call_id = "callId",
        .content = "content",
    };
};
