const StreamSession = @import("stream_session.zig").StreamSession;

pub const GetStreamSessionResponse = struct {
    /// List of stream details.
    stream_session: ?StreamSession,

    pub const json_field_names = .{
        .stream_session = "streamSession",
    };
};
