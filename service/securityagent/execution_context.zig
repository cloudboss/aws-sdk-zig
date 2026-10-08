const ContextType = @import("context_type.zig").ContextType;

/// Contains contextual information about the execution of a pentest job, such
/// as errors, warnings, or informational messages.
pub const ExecutionContext = struct {
    /// The context message.
    context: ?[]const u8 = null,

    /// The type of context. Valid values include ERROR, CLIENT_ERROR, WARNING, and
    /// INFO.
    context_type: ?ContextType = null,

    /// The date and time the context was recorded, in UTC format.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .context = "context",
        .context_type = "contextType",
        .timestamp = "timestamp",
    };
};
