const Attendee = @import("attendee.zig").Attendee;
const Meeting = @import("meeting.zig").Meeting;

/// Information required to join the call.
pub const ConnectionData = struct {
    /// The attendee information, including attendee ID and join token.
    attendee: ?Attendee = null,

    /// A meeting created using the Amazon Chime SDK.
    meeting: ?Meeting = null,

    pub const json_field_names = .{
        .attendee = "Attendee",
        .meeting = "Meeting",
    };
};
