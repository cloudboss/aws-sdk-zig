/// The attendee information, including attendee ID and join token.
pub const Attendee = struct {
    /// The Amazon Chime SDK attendee ID.
    attendee_id: ?[]const u8 = null,

    /// The join token used by the Amazon Chime SDK attendee.
    join_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attendee_id = "AttendeeId",
        .join_token = "JoinToken",
    };
};
