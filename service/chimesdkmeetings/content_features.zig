const ContentResolution = @import("content_resolution.zig").ContentResolution;

/// Lists the content (screen share) features for the meeting. Applies to all
/// attendees.
///
/// If you specify `MeetingFeatures:Content:MaxResolution:None` when you create
/// a meeting, all API requests that include `SendReceive`, `Send`, or
/// `Receive` for `AttendeeCapabilities:Content` will be rejected with
/// `ValidationError 400`.
pub const ContentFeatures = struct {
    /// The maximum resolution for the meeting content.
    ///
    /// Defaults to `FHD`. To use `UHD`, you must also provide a
    /// `MeetingFeatures:Attendee:MaxCount`
    /// value and override the default size limit of 250 attendees.
    max_resolution: ?ContentResolution = null,

    pub const json_field_names = .{
        .max_resolution = "MaxResolution",
    };
};
