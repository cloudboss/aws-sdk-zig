const VideoResolution = @import("video_resolution.zig").VideoResolution;

/// The video features set for the meeting. Applies to all attendees.
///
/// If you specify `MeetingFeatures:Video:MaxResolution:None` when you create a
/// meeting, all API requests
/// that include `SendReceive`, `Send`, or `Receive` for
/// `AttendeeCapabilities:Video` will be rejected with `ValidationError 400`.
pub const VideoFeatures = struct {
    /// The maximum video resolution for the meeting. Applies to all attendees.
    ///
    /// Defaults to `HD`. To use `FHD`, you must also provide a
    /// `MeetingFeatures:Attendee:MaxCount` value and override the default size
    /// limit of 250 attendees.
    max_resolution: ?VideoResolution,

    pub const json_field_names = .{
        .max_resolution = "MaxResolution",
    };
};
