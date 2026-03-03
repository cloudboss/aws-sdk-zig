const AdsOnDeliveryRestrictions = @import("ads_on_delivery_restrictions.zig").AdsOnDeliveryRestrictions;
const __AdTriggersElement = @import("ad_triggers_element.zig").__AdTriggersElement;
const DashEncryption = @import("dash_encryption.zig").DashEncryption;
const ManifestLayout = @import("manifest_layout.zig").ManifestLayout;
const __PeriodTriggersElement = @import("period_triggers_element.zig").__PeriodTriggersElement;
const Profile = @import("profile.zig").Profile;
const SegmentTemplateFormat = @import("segment_template_format.zig").SegmentTemplateFormat;
const StreamSelection = @import("stream_selection.zig").StreamSelection;
const UtcTiming = @import("utc_timing.zig").UtcTiming;

/// A Dynamic Adaptive Streaming over HTTP (DASH) packaging configuration.
pub const DashPackage = struct {
    ads_on_delivery_restrictions: ?AdsOnDeliveryRestrictions = null,

    ad_triggers: ?[]const __AdTriggersElement = null,

    encryption: ?DashEncryption = null,

    /// When enabled, an I-Frame only stream will be included in the output.
    include_iframe_only_stream: ?bool = null,

    /// Determines the position of some tags in the Media Presentation Description
    /// (MPD). When set to FULL, elements like SegmentTemplate and ContentProtection
    /// are included in each Representation. When set to COMPACT, duplicate elements
    /// are combined and presented at the AdaptationSet level. When set to
    /// DRM_TOP_LEVEL_COMPACT, content protection elements are placed the MPD level
    /// and referenced at the AdaptationSet level.
    manifest_layout: ?ManifestLayout = null,

    /// Time window (in seconds) contained in each manifest.
    manifest_window_seconds: ?i32 = null,

    /// Minimum duration (in seconds) that a player will buffer media before
    /// starting the presentation.
    min_buffer_time_seconds: ?i32 = null,

    /// Minimum duration (in seconds) between potential changes to the Dynamic
    /// Adaptive Streaming over HTTP (DASH) Media Presentation Description (MPD).
    min_update_period_seconds: ?i32 = null,

    /// A list of triggers that controls when the outgoing Dynamic Adaptive
    /// Streaming over HTTP (DASH)
    /// Media Presentation Description (MPD) will be partitioned into multiple
    /// periods. If empty, the content will not
    /// be partitioned into more than one period. If the list contains "ADS", new
    /// periods will be created where
    /// the Channel source contains SCTE-35 ad markers.
    period_triggers: ?[]const __PeriodTriggersElement = null,

    /// The Dynamic Adaptive Streaming over HTTP (DASH) profile type. When set to
    /// "HBBTV_1_5", HbbTV 1.5 compliant output is enabled. When set to
    /// "DVB-DASH_2014", DVB-DASH 2014 compliant output is enabled.
    profile: ?Profile = null,

    /// Duration (in seconds) of each segment. Actual segments will be
    /// rounded to the nearest multiple of the source segment duration.
    segment_duration_seconds: ?i32 = null,

    /// Determines the type of SegmentTemplate included in the Media Presentation
    /// Description (MPD). When set to NUMBER_WITH_TIMELINE, a full timeline is
    /// presented in each SegmentTemplate, with $Number$ media URLs. When set to
    /// TIME_WITH_TIMELINE, a full timeline is presented in each SegmentTemplate,
    /// with $Time$ media URLs. When set to NUMBER_WITH_DURATION, only a duration is
    /// included in each SegmentTemplate, with $Number$ media URLs.
    segment_template_format: ?SegmentTemplateFormat = null,

    stream_selection: ?StreamSelection = null,

    /// Duration (in seconds) to delay live content before presentation.
    suggested_presentation_delay_seconds: ?i32 = null,

    /// Determines the type of UTCTiming included in the Media Presentation
    /// Description (MPD)
    utc_timing: ?UtcTiming = null,

    /// Specifies the value attribute of the UTCTiming field when utcTiming is set
    /// to HTTP-ISO, HTTP-HEAD or HTTP-XSDATE
    utc_timing_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .ads_on_delivery_restrictions = "AdsOnDeliveryRestrictions",
        .ad_triggers = "AdTriggers",
        .encryption = "Encryption",
        .include_iframe_only_stream = "IncludeIframeOnlyStream",
        .manifest_layout = "ManifestLayout",
        .manifest_window_seconds = "ManifestWindowSeconds",
        .min_buffer_time_seconds = "MinBufferTimeSeconds",
        .min_update_period_seconds = "MinUpdatePeriodSeconds",
        .period_triggers = "PeriodTriggers",
        .profile = "Profile",
        .segment_duration_seconds = "SegmentDurationSeconds",
        .segment_template_format = "SegmentTemplateFormat",
        .stream_selection = "StreamSelection",
        .suggested_presentation_delay_seconds = "SuggestedPresentationDelaySeconds",
        .utc_timing = "UtcTiming",
        .utc_timing_uri = "UtcTimingUri",
    };
};
