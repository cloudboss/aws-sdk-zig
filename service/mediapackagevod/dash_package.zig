const DashManifest = @import("dash_manifest.zig").DashManifest;
const DashEncryption = @import("dash_encryption.zig").DashEncryption;
const __PeriodTriggersElement = @import("period_triggers_element.zig").__PeriodTriggersElement;
const SegmentTemplateFormat = @import("segment_template_format.zig").SegmentTemplateFormat;

/// A Dynamic Adaptive Streaming over HTTP (DASH) packaging configuration.
pub const DashPackage = struct {
    /// A list of DASH manifest configurations.
    dash_manifests: []const DashManifest,

    encryption: ?DashEncryption = null,

    /// When includeEncoderConfigurationInSegments is set to true, MediaPackage
    /// places your encoder's Sequence Parameter Set (SPS), Picture Parameter Set
    /// (PPS), and Video Parameter Set (VPS) metadata in every video segment instead
    /// of in the init fragment. This lets you use different SPS/PPS/VPS settings
    /// for your assets during content playback.
    include_encoder_configuration_in_segments: ?bool = null,

    /// When enabled, an I-Frame only stream will be included in the output.
    include_iframe_only_stream: ?bool = null,

    /// A list of triggers that controls when the outgoing Dynamic Adaptive
    /// Streaming over HTTP (DASH)
    /// Media Presentation Description (MPD) will be partitioned into multiple
    /// periods. If empty, the content will not
    /// be partitioned into more than one period. If the list contains "ADS", new
    /// periods will be created where
    /// the Asset contains SCTE-35 ad markers.
    period_triggers: ?[]const __PeriodTriggersElement = null,

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

    pub const json_field_names = .{
        .dash_manifests = "DashManifests",
        .encryption = "Encryption",
        .include_encoder_configuration_in_segments = "IncludeEncoderConfigurationInSegments",
        .include_iframe_only_stream = "IncludeIframeOnlyStream",
        .period_triggers = "PeriodTriggers",
        .segment_duration_seconds = "SegmentDurationSeconds",
        .segment_template_format = "SegmentTemplateFormat",
    };
};
