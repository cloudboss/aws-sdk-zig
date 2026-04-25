const ContentDeltaEvent = @import("content_delta_event.zig").ContentDeltaEvent;
const ContentStartEvent = @import("content_start_event.zig").ContentStartEvent;
const ContentStopEvent = @import("content_stop_event.zig").ContentStopEvent;

/// A structure representing a response chunk that contains exactly one of the
/// possible event types: `contentStart`, `contentDelta`, or `contentStop`.
pub const ResponseChunk = struct {
    /// An event containing incremental output (stdout or stderr) from the command
    /// execution. These are the middle chunks.
    content_delta: ?ContentDeltaEvent = null,

    /// An event indicating the start of content streaming from the command
    /// execution. This is the first chunk received.
    content_start: ?ContentStartEvent = null,

    /// An event indicating the completion of the command execution, including the
    /// exit code and final status. This is the last chunk received.
    content_stop: ?ContentStopEvent = null,

    pub const json_field_names = .{
        .content_delta = "contentDelta",
        .content_start = "contentStart",
        .content_stop = "contentStop",
    };
};
