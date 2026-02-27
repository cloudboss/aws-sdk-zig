/// Filter configuration includes settings for manifest filtering, start and end
/// times, and time delay that apply to all of your egress requests for this
/// manifest.
pub const FilterConfiguration = struct {
    /// Optionally specify the clip start time for all of your manifest egress
    /// requests. When you include clip start time, note that you cannot use clip
    /// start time query parameters for this manifest's endpoint URL.
    clip_start_time: ?i64,

    /// Optionally specify one or more DRM settings for all of your manifest egress
    /// requests. When you include a DRM setting, note that you cannot use an
    /// identical DRM setting query parameter for this manifest's endpoint URL.
    drm_settings: ?[]const u8,

    /// Optionally specify the end time for all of your manifest egress requests.
    /// When you include end time, note that you cannot use end time query
    /// parameters for this manifest's endpoint URL.
    end: ?i64,

    /// Optionally specify one or more manifest filters for all of your manifest
    /// egress requests. When you include a manifest filter, note that you cannot
    /// use an identical manifest filter query parameter for this manifest's
    /// endpoint URL.
    manifest_filter: ?[]const u8,

    /// Optionally specify the start time for all of your manifest egress requests.
    /// When you include start time, note that you cannot use start time query
    /// parameters for this manifest's endpoint URL.
    start: ?i64,

    /// Optionally specify the time delay for all of your manifest egress requests.
    /// Enter a value that is smaller than your endpoint's startover window. When
    /// you include time delay, note that you cannot use time delay query parameters
    /// for this manifest's endpoint URL.
    time_delay_seconds: ?i32,

    pub const json_field_names = .{
        .clip_start_time = "ClipStartTime",
        .drm_settings = "DrmSettings",
        .end = "End",
        .manifest_filter = "ManifestFilter",
        .start = "Start",
        .time_delay_seconds = "TimeDelaySeconds",
    };
};
