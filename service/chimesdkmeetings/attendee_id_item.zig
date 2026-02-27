/// A structure that contains one or more attendee IDs.
pub const AttendeeIdItem = struct {
    /// A list of one or more attendee IDs.
    attendee_id: []const u8,

    pub const json_field_names = .{
        .attendee_id = "AttendeeId",
    };
};
