/// The video streams for a specified media pipeline. The total number of
/// video streams can't exceed 25.
pub const SelectedVideoStreams = struct {
    /// The attendee IDs of the streams selected for a media pipeline.
    attendee_ids: ?[]const []const u8 = null,

    /// The external user IDs of the streams selected for a media pipeline.
    external_user_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .attendee_ids = "AttendeeIds",
        .external_user_ids = "ExternalUserIds",
    };
};
