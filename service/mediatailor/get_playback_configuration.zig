const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdConditioningConfiguration = @import("ad_conditioning_configuration.zig").AdConditioningConfiguration;
const AdDecisionServerConfiguration = @import("ad_decision_server_configuration.zig").AdDecisionServerConfiguration;
const AdsPersonalizationConcurrency = @import("ads_personalization_concurrency.zig").AdsPersonalizationConcurrency;
const AdsPersonalizationTimeouts = @import("ads_personalization_timeouts.zig").AdsPersonalizationTimeouts;
const AvailSuppression = @import("avail_suppression.zig").AvailSuppression;
const BeaconingConfiguration = @import("beaconing_configuration.zig").BeaconingConfiguration;
const Bumper = @import("bumper.zig").Bumper;
const CdnConfiguration = @import("cdn_configuration.zig").CdnConfiguration;
const DashConfiguration = @import("dash_configuration.zig").DashConfiguration;
const HlsConfiguration = @import("hls_configuration.zig").HlsConfiguration;
const InsertionMode = @import("insertion_mode.zig").InsertionMode;
const LivePreRollConfiguration = @import("live_pre_roll_configuration.zig").LivePreRollConfiguration;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const ManifestProcessingRules = @import("manifest_processing_rules.zig").ManifestProcessingRules;
const YieldOptimizationConfiguration = @import("yield_optimization_configuration.zig").YieldOptimizationConfiguration;

pub const GetPlaybackConfigurationInput = struct {
    /// The identifier for the playback configuration.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const GetPlaybackConfigurationOutput = struct {
    /// The setting that indicates what conditioning MediaTailor will perform on ads
    /// that the ad decision server (ADS) returns, and what priority MediaTailor
    /// uses when inserting ads.
    ad_conditioning_configuration: ?AdConditioningConfiguration = null,

    /// The configuration for customizing HTTP requests to the ad decision server
    /// (ADS). This includes settings for request method, headers, body content, and
    /// compression options.
    ad_decision_server_configuration: ?AdDecisionServerConfiguration = null,

    /// The URL for the ad decision server (ADS). This includes the specification of
    /// static parameters and placeholders for dynamic parameters. AWS Elemental
    /// MediaTailor substitutes player-specific and session-specific parameters as
    /// needed when calling the ADS. Alternately, for testing, you can provide a
    /// static VAST URL. The maximum length is 25,000 characters.
    ad_decision_server_url: ?[]const u8 = null,

    /// The concurrency settings for ad decision server interactions. These settings
    /// control how many simultaneous ADS requests MediaTailor makes per manifest
    /// request.
    ads_personalization_concurrency: ?AdsPersonalizationConcurrency = null,

    /// The timeout settings for ad decision server interactions. These settings
    /// control how long MediaTailor waits for ADS responses and the total time
    /// budget for ad personalization across live, VOD, and prefetch workflows.
    ads_personalization_timeouts: ?AdsPersonalizationTimeouts = null,

    /// The configuration for avail suppression, also known as ad suppression. For
    /// more information about ad suppression, see [Ad
    /// Suppression](https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html).
    avail_suppression: ?AvailSuppression = null,

    /// The beaconing configuration for this playback configuration, which controls
    /// whether MediaTailor includes beacons of its own in the ad tracking response.
    /// MediaTailor always returns this setting. If you created the playback
    /// configuration before this setting existed, MediaTailor reports
    /// `ReportingMode` as `INSIGHTS`. This is also the value MediaTailor uses for
    /// that configuration at playback time.
    beaconing_configuration: ?BeaconingConfiguration = null,

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

    /// The configuration for DASH content.
    dash_configuration: ?DashConfiguration = null,

    /// The dual-stack (IPv4 and IPv6) URL that your player accesses to get a
    /// manifest from AWS Elemental MediaTailor. The session uses server-side
    /// reporting.
    dual_stack_playback_endpoint_prefix: ?[]const u8 = null,

    /// The dual-stack (IPv4 and IPv6) URL that your player uses to initialize a
    /// session that uses client-side reporting.
    dual_stack_session_initialization_endpoint_prefix: ?[]const u8 = null,

    /// A map of lifecycle hook event names to function identifiers. The function
    /// mapping specifies which function MediaTailor executes at each lifecycle hook
    /// during ad insertion. Valid keys are `PRE_SESSION_INITIALIZATION`,
    /// `PRE_ADS_REQUEST`, `POST_ADS_RESPONSE`, and `PRE_MANIFEST_INSERTION`. For
    /// more information, see [Functions lifecycle
    /// hooks](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-hooks.html) in the *MediaTailor User Guide*.
    function_mapping: ?[]const aws.map.StringMapEntry = null,

    /// The configuration for HLS content.
    hls_configuration: ?HlsConfiguration = null,

    /// The setting that controls whether players can use stitched or guided ad
    /// insertion. The default, `STITCHED_ONLY`, forces all player sessions to use
    /// stitched (server-side) ad insertion. Choosing `PLAYER_SELECT` allows players
    /// to select either stitched or guided ad insertion at session-initialization
    /// time. The default for players that do not specify an insertion mode is
    /// stitched.
    insertion_mode: ?InsertionMode = null,

    /// The configuration for pre-roll ad insertion.
    live_pre_roll_configuration: ?LivePreRollConfiguration = null,

    /// The configuration that defines where AWS Elemental MediaTailor sends logs
    /// for the playback configuration.
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

    /// The URL that your player accesses to get a manifest from AWS Elemental
    /// MediaTailor. The session uses server-side reporting.
    playback_endpoint_prefix: ?[]const u8 = null,

    /// The URL that your player uses to initialize a session that uses client-side
    /// reporting.
    session_initialization_endpoint_prefix: ?[]const u8 = null,

    /// The URL for a high-quality video asset to transcode and use to fill in time
    /// that's not used by ads. AWS Elemental MediaTailor shows the slate to fill in
    /// gaps in media content. Configuring the slate is optional for non-VPAID
    /// playback configurations. For VPAID, the slate is required because
    /// MediaTailor provides it in the slots designated for dynamic ad content. The
    /// slate must be a high-quality asset that contains both audio and video.
    slate_ad_url: ?[]const u8 = null,

    /// The tags assigned to the playback configuration. Tags are key-value pairs
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

    /// Configuration for Yield Optimization, which fills unsold ad inventory in ad
    /// breaks with programmatic ads from Amazon Publisher Services (APS).
    yield_optimization_configuration: ?YieldOptimizationConfiguration = null,

    pub const json_field_names = .{
        .ad_conditioning_configuration = "AdConditioningConfiguration",
        .ad_decision_server_configuration = "AdDecisionServerConfiguration",
        .ad_decision_server_url = "AdDecisionServerUrl",
        .ads_personalization_concurrency = "AdsPersonalizationConcurrency",
        .ads_personalization_timeouts = "AdsPersonalizationTimeouts",
        .avail_suppression = "AvailSuppression",
        .beaconing_configuration = "BeaconingConfiguration",
        .bumper = "Bumper",
        .cdn_configuration = "CdnConfiguration",
        .configuration_aliases = "ConfigurationAliases",
        .dash_configuration = "DashConfiguration",
        .dual_stack_playback_endpoint_prefix = "DualStackPlaybackEndpointPrefix",
        .dual_stack_session_initialization_endpoint_prefix = "DualStackSessionInitializationEndpointPrefix",
        .function_mapping = "FunctionMapping",
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
        .yield_optimization_configuration = "YieldOptimizationConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPlaybackConfigurationInput, options: CallOptions) !GetPlaybackConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediatailor", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetPlaybackConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/playbackConfiguration/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPlaybackConfigurationOutput {
    const result: GetPlaybackConfigurationOutput = try aws.json.parseJsonObject(
        GetPlaybackConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
