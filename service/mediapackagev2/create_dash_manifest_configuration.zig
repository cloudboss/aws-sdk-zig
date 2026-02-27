const DashBaseUrl = @import("dash_base_url.zig").DashBaseUrl;
const DashCompactness = @import("dash_compactness.zig").DashCompactness;
const DashDrmSignaling = @import("dash_drm_signaling.zig").DashDrmSignaling;
const DashDvbSettings = @import("dash_dvb_settings.zig").DashDvbSettings;
const FilterConfiguration = @import("filter_configuration.zig").FilterConfiguration;
const DashPeriodTrigger = @import("dash_period_trigger.zig").DashPeriodTrigger;
const DashProfile = @import("dash_profile.zig").DashProfile;
const DashProgramInformation = @import("dash_program_information.zig").DashProgramInformation;
const ScteDash = @import("scte_dash.zig").ScteDash;
const DashSegmentTemplateFormat = @import("dash_segment_template_format.zig").DashSegmentTemplateFormat;
const DashSubtitleConfiguration = @import("dash_subtitle_configuration.zig").DashSubtitleConfiguration;
const DashUtcTiming = @import("dash_utc_timing.zig").DashUtcTiming;

/// Create a DASH manifest configuration.
pub const CreateDashManifestConfiguration = struct {
    /// The base URLs to use for retrieving segments.
    base_urls: ?[]const DashBaseUrl,

    /// The layout of the DASH manifest that MediaPackage produces. `STANDARD`
    /// indicates a default manifest, which is compacted. `NONE` indicates a full
    /// manifest.
    ///
    /// For information about compactness, see [DASH manifest
    /// compactness](https://docs.aws.amazon.com/mediapackage/latest/userguide/compacted.html) in the *Elemental MediaPackage v2 User Guide*.
    compactness: ?DashCompactness,

    /// Determines how the DASH manifest signals the DRM content.
    drm_signaling: ?DashDrmSignaling,

    /// For endpoints that use the DVB-DASH profile only. The font download and
    /// error reporting information that you want MediaPackage to pass through to
    /// the manifest.
    dvb_settings: ?DashDvbSettings,

    filter_configuration: ?FilterConfiguration,

    /// A short string that's appended to the endpoint URL. The child manifest name
    /// creates a unique path to this endpoint.
    manifest_name: []const u8,

    /// The total duration (in seconds) of the manifest's content.
    manifest_window_seconds: ?i32,

    /// Minimum amount of content (in seconds) that a player must keep available in
    /// the buffer.
    min_buffer_time_seconds: ?i32,

    /// Minimum amount of time (in seconds) that the player should wait before
    /// requesting updates to the manifest.
    min_update_period_seconds: ?i32,

    /// A list of triggers that controls when AWS Elemental MediaPackage separates
    /// the MPEG-DASH manifest into multiple periods. Type `ADS` to indicate that
    /// AWS Elemental MediaPackage must create periods in the output manifest that
    /// correspond to SCTE-35 ad markers in the input source. Leave this value empty
    /// to indicate that the manifest is contained all in one period. For more
    /// information about periods in the DASH manifest, see [Multi-period DASH in
    /// AWS Elemental
    /// MediaPackage](https://docs.aws.amazon.com/mediapackage/latest/userguide/multi-period.html).
    period_triggers: ?[]const DashPeriodTrigger,

    /// The profile that the output is compliant with.
    profiles: ?[]const DashProfile,

    /// Details about the content that you want MediaPackage to pass through in the
    /// manifest to the playback device.
    program_information: ?DashProgramInformation,

    /// The SCTE configuration.
    scte_dash: ?ScteDash,

    /// Determines the type of variable used in the `media` URL of the
    /// `SegmentTemplate` tag in the manifest. Also specifies if segment timeline
    /// information is included in `SegmentTimeline` or `SegmentTemplate`.
    ///
    /// Value description:
    ///
    /// * `NUMBER_WITH_TIMELINE` - The `$Number$` variable is used in the `media`
    ///   URL. The value of this variable is the sequential number of the segment. A
    ///   full `SegmentTimeline` object is presented in each `SegmentTemplate`.
    segment_template_format: ?DashSegmentTemplateFormat,

    /// The configuration for DASH subtitles.
    subtitle_configuration: ?DashSubtitleConfiguration,

    /// The amount of time (in seconds) that the player should be from the end of
    /// the manifest.
    suggested_presentation_delay_seconds: ?i32,

    /// Determines the type of UTC timing included in the DASH Media Presentation
    /// Description (MPD).
    utc_timing: ?DashUtcTiming,

    pub const json_field_names = .{
        .base_urls = "BaseUrls",
        .compactness = "Compactness",
        .drm_signaling = "DrmSignaling",
        .dvb_settings = "DvbSettings",
        .filter_configuration = "FilterConfiguration",
        .manifest_name = "ManifestName",
        .manifest_window_seconds = "ManifestWindowSeconds",
        .min_buffer_time_seconds = "MinBufferTimeSeconds",
        .min_update_period_seconds = "MinUpdatePeriodSeconds",
        .period_triggers = "PeriodTriggers",
        .profiles = "Profiles",
        .program_information = "ProgramInformation",
        .scte_dash = "ScteDash",
        .segment_template_format = "SegmentTemplateFormat",
        .subtitle_configuration = "SubtitleConfiguration",
        .suggested_presentation_delay_seconds = "SuggestedPresentationDelaySeconds",
        .utc_timing = "UtcTiming",
    };
};
