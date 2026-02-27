/// Lists the maximum number of attendees allowed into the meeting.
///
/// If you specify `FHD` for `MeetingFeatures:Video:MaxResolution`, or if you
/// specify
/// `UHD` for `MeetingFeatures:Content:MaxResolution`, the maximum number of
/// attendees changes from the default of `250` to `25`.
pub const AttendeeFeatures = struct {
    /// The maximum number of attendees allowed into the meeting.
    max_count: ?i32,

    pub const json_field_names = .{
        .max_count = "MaxCount",
    };
};
