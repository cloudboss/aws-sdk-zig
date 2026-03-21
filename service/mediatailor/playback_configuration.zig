const aws = @import("aws");

const AdConditioningConfiguration = @import("ad_conditioning_configuration.zig").AdConditioningConfiguration;
const AdDecisionServerConfiguration = @import("ad_decision_server_configuration.zig").AdDecisionServerConfiguration;
const AvailSuppression = @import("avail_suppression.zig").AvailSuppression;
const Bumper = @import("bumper.zig").Bumper;
const CdnConfiguration = @import("cdn_configuration.zig").CdnConfiguration;
const DashConfiguration = @import("dash_configuration.zig").DashConfiguration;
const HlsConfiguration = @import("hls_configuration.zig").HlsConfiguration;
const InsertionMode = @import("insertion_mode.zig").InsertionMode;
const LivePreRollConfiguration = @import("live_pre_roll_configuration.zig").LivePreRollConfiguration;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const ManifestProcessingRules = @import("manifest_processing_rules.zig").ManifestProcessingRules;

/// A playback configuration. For information about MediaTailor configurations,
/// see [Working with configurations in AWS Elemental
/// MediaTailor](https://docs.aws.amazon.com/mediatailor/latest/ug/configurations.html).
pub const PlaybackConfiguration = struct {
    /// The setting that indicates what conditioning MediaTailor will perform on ads
    /// that the ad decision server (ADS) returns, and what priority MediaTailor
    /// uses when inserting ads.
    ad_conditioning_configuration: ?AdConditioningConfiguration = null,

    ad_decision_server_configuration: ?AdDecisionServerConfiguration = null,

    /// The URL for the ad decision server (ADS). This includes the specification of
    /// static parameters and placeholders for dynamic parameters. AWS Elemental
    /// MediaTailor substitutes player-specific and session-specific parameters as
    /// needed when calling the ADS. Alternately, for testing you can provide a
    /// static VAST URL. The maximum length is 25,000 characters.
    ad_decision_server_url: ?[]const u8 = null,

    /// The configuration for avail suppression, also known as ad suppression. For
    /// more information about ad suppression, see [Ad
    /// Suppression](https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html).
    avail_suppression: ?AvailSuppression = null,

    /// The configuration for bumpers. Bumpers are short audio or video clips that
    /// play at the start or before the end of an ad break. To learn more about
    /// bumpers, see
    /// [Bumpers](https://docs.aws.amazon.com/mediatailor/latest/ug/bumpers.html).
    bumper: ?Bumper = null,

    /// The configuration for using a content delivery network (CDN), like Amazon
    /// CloudFront, for content and ad segment management.
    cdn_configuration: ?CdnConfiguration = null,

    /// The player parameters and aliases used as dynamic variables during session
    /// initialization. For more information, see [Domain
    /// Variables](https://docs.aws.amazon.com/mediatailor/latest/ug/variables-domains.html).
    configuration_aliases: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// The configuration for a DASH source.
    dash_configuration: ?DashConfiguration = null,

    /// The configuration for HLS content.
    hls_configuration: ?HlsConfiguration = null,

    /// The setting that controls whether players can use stitched or guided ad
    /// insertion. The default, `STITCHED_ONLY`, forces all player sessions to use
    /// stitched (server-side) ad insertion. Choosing `PLAYER_SELECT` allows players
    /// to select either stitched or guided ad insertion at session-initialization
    /// time. The default for players that do not specify an insertion mode is
    /// stitched.
    insertion_mode: InsertionMode = .stitched_only,

    /// The configuration for pre-roll ad insertion.
    live_pre_roll_configuration: ?LivePreRollConfiguration = null,

    /// Defines where AWS Elemental MediaTailor sends logs for the playback
    /// configuration.
    log_configuration: ?LogConfiguration = null,

    /// The configuration for manifest processing rules. Manifest processing rules
    /// enable customization of the personalized manifests created by MediaTailor.
    manifest_processing_rules: ?ManifestProcessingRules = null,

    /// The identifier for the playback configuration.
    name: ?[]const u8 = null,

    /// Defines the maximum duration of underfilled ad time (in seconds) allowed in
    /// an ad break. If the duration of underfilled ad time exceeds the
    /// personalization threshold, then the personalization of the ad break is
    /// abandoned and the underlying content is shown. This feature applies to *ad
    /// replacement* in live and VOD streams, rather than ad insertion, because it
    /// relies on an underlying content stream. For more information about ad break
    /// behavior, including ad replacement and insertion, see [Ad Behavior in AWS
    /// Elemental
    /// MediaTailor](https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html).
    personalization_threshold_seconds: ?i32 = null,

    /// The Amazon Resource Name (ARN) for the playback configuration.
    playback_configuration_arn: ?[]const u8 = null,

    /// The URL that the player accesses to get a manifest from AWS Elemental
    /// MediaTailor.
    playback_endpoint_prefix: ?[]const u8 = null,

    /// The URL that the player uses to initialize a session that uses client-side
    /// reporting.
    session_initialization_endpoint_prefix: ?[]const u8 = null,

    /// The URL for a video asset to transcode and use to fill in time that's not
    /// used by ads. AWS Elemental MediaTailor shows the slate to fill in gaps in
    /// media content. Configuring the slate is optional for non-VPAID playback
    /// configurations. For VPAID, the slate is required because MediaTailor
    /// provides it in the slots designated for dynamic ad content. The slate must
    /// be a high-quality asset that contains both audio and video.
    slate_ad_url: ?[]const u8 = null,

    /// The tags to assign to the playback configuration. Tags are key-value pairs
    /// that you can associate with Amazon resources to help with organization,
    /// access control, and cost tracking. For more information, see [Tagging AWS
    /// Elemental MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name that is used to associate this playback configuration with a custom
    /// transcode profile. This overrides the dynamic transcoding defaults of
    /// MediaTailor. Use this only if you have already set up custom profiles with
    /// the help of AWS Support.
    transcode_profile_name: ?[]const u8 = null,

    /// The URL prefix for the parent manifest for the stream, minus the asset ID.
    /// The maximum length is 512 characters.
    video_content_source_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .ad_conditioning_configuration = "AdConditioningConfiguration",
        .ad_decision_server_configuration = "AdDecisionServerConfiguration",
        .ad_decision_server_url = "AdDecisionServerUrl",
        .avail_suppression = "AvailSuppression",
        .bumper = "Bumper",
        .cdn_configuration = "CdnConfiguration",
        .configuration_aliases = "ConfigurationAliases",
        .dash_configuration = "DashConfiguration",
        .hls_configuration = "HlsConfiguration",
        .insertion_mode = "InsertionMode",
        .live_pre_roll_configuration = "LivePreRollConfiguration",
        .log_configuration = "LogConfiguration",
        .manifest_processing_rules = "ManifestProcessingRules",
        .name = "Name",
        .personalization_threshold_seconds = "PersonalizationThresholdSeconds",
        .playback_configuration_arn = "PlaybackConfigurationArn",
        .playback_endpoint_prefix = "PlaybackEndpointPrefix",
        .session_initialization_endpoint_prefix = "SessionInitializationEndpointPrefix",
        .slate_ad_url = "SlateAdUrl",
        .tags = "Tags",
        .transcode_profile_name = "TranscodeProfileName",
        .video_content_source_url = "VideoContentSourceUrl",
    };
};
