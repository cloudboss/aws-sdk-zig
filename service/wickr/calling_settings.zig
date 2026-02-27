/// Defines the calling feature permissions and settings for users in a security
/// group, controlling what types of calls users can initiate and participate
/// in.
pub const CallingSettings = struct {
    /// Specifies whether users can start one-to-one calls.
    can_start_11_call: ?bool,

    /// Specifies whether users can make video calls (as opposed to audio-only
    /// calls). Valid only when audio call(canStart11Call) is enabled.
    can_video_call: ?bool,

    /// When enabled, forces all calls to use TCP protocol instead of UDP for
    /// network traversal.
    force_tcp_call: ?bool,

    pub const json_field_names = .{
        .can_start_11_call = "canStart11Call",
        .can_video_call = "canVideoCall",
        .force_tcp_call = "forceTcpCall",
    };
};
