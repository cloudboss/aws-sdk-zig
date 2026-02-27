const Attendee = @import("attendee.zig").Attendee;
const WebRTCMeeting = @import("web_rtc_meeting.zig").WebRTCMeeting;

/// Creates the participant’s WebRTC connection data required for the client
/// application
/// (mobile or web) to connect to the call.
pub const WebRTCConnection = struct {
    attendee: ?Attendee,

    /// A meeting created using the Amazon Chime SDK.
    meeting: ?WebRTCMeeting,

    pub const json_field_names = .{
        .attendee = "Attendee",
        .meeting = "Meeting",
    };
};
