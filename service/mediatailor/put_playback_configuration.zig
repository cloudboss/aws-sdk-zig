const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdConditioningConfiguration = @import("ad_conditioning_configuration.zig").AdConditioningConfiguration;
const AdDecisionServerConfiguration = @import("ad_decision_server_configuration.zig").AdDecisionServerConfiguration;
const AvailSuppression = @import("avail_suppression.zig").AvailSuppression;
const Bumper = @import("bumper.zig").Bumper;
const CdnConfiguration = @import("cdn_configuration.zig").CdnConfiguration;
const DashConfigurationForPut = @import("dash_configuration_for_put.zig").DashConfigurationForPut;
const InsertionMode = @import("insertion_mode.zig").InsertionMode;
const LivePreRollConfiguration = @import("live_pre_roll_configuration.zig").LivePreRollConfiguration;
const ManifestProcessingRules = @import("manifest_processing_rules.zig").ManifestProcessingRules;
const DashConfiguration = @import("dash_configuration.zig").DashConfiguration;
const HlsConfiguration = @import("hls_configuration.zig").HlsConfiguration;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;

pub const PutPlaybackConfigurationInput = struct {
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

    /// The configuration for DASH content.
    dash_configuration: ?DashConfigurationForPut = null,

    /// The setting that controls whether players can use stitched or guided ad
    /// insertion. The default, `STITCHED_ONLY`, forces all player sessions to use
    /// stitched (server-side) ad insertion. Choosing `PLAYER_SELECT` allows players
    /// to select either stitched or guided ad insertion at session-initialization
    /// time. The default for players that do not specify an insertion mode is
    /// stitched.
    insertion_mode: InsertionMode = "STITCHED_ONLY",

    /// The configuration for pre-roll ad insertion.
    live_pre_roll_configuration: ?LivePreRollConfiguration = null,

    /// The configuration for manifest processing rules. Manifest processing rules
    /// enable customization of the personalized manifests created by MediaTailor.
    manifest_processing_rules: ?ManifestProcessingRules = null,

    /// The identifier for the playback configuration.
    name: []const u8,

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

    /// The URL for a high-quality video asset to transcode and use to fill in time
    /// that's not used by ads. AWS Elemental MediaTailor shows the slate to fill in
    /// gaps in media content. Configuring the slate is optional for non-VPAID
    /// configurations. For VPAID, the slate is required because MediaTailor
    /// provides it in the slots that are designated for dynamic ad content. The
    /// slate must be a high-quality asset that contains both audio and video.
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
        .insertion_mode = "InsertionMode",
        .live_pre_roll_configuration = "LivePreRollConfiguration",
        .manifest_processing_rules = "ManifestProcessingRules",
        .name = "Name",
        .personalization_threshold_seconds = "PersonalizationThresholdSeconds",
        .slate_ad_url = "SlateAdUrl",
        .tags = "Tags",
        .transcode_profile_name = "TranscodeProfileName",
        .video_content_source_url = "VideoContentSourceUrl",
    };
};

pub const PutPlaybackConfigurationOutput = struct {
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

    /// The configuration for DASH content.
    dash_configuration: ?DashConfiguration = null,

    /// The configuration for HLS content.
    hls_configuration: ?HlsConfiguration = null,

    /// The setting that controls whether players can use stitched or guided ad
    /// insertion. The default, `STITCHED_ONLY`, forces all player sessions to use
    /// stitched (server-side) ad insertion. Choosing `PLAYER_SELECT` allows players
    /// to select either stitched or guided ad insertion at session-initialization
    /// time. The default for players that do not specify an insertion mode is
    /// stitched.
    insertion_mode: InsertionMode = "STITCHED_ONLY",

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

    /// The Amazon Resource Name (ARN) associated with the playback configuration.
    playback_configuration_arn: ?[]const u8 = null,

    /// The playback endpoint prefix associated with the playback configuration.
    playback_endpoint_prefix: ?[]const u8 = null,

    /// The session initialization endpoint prefix associated with the playback
    /// configuration.
    session_initialization_endpoint_prefix: ?[]const u8 = null,

    /// The URL for a high-quality video asset to transcode and use to fill in time
    /// that's not used by ads. AWS Elemental MediaTailor shows the slate to fill in
    /// gaps in media content. Configuring the slate is optional for non-VPAID
    /// configurations. For VPAID, the slate is required because MediaTailor
    /// provides it in the slots that are designated for dynamic ad content. The
    /// slate must be a high-quality asset that contains both audio and video.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPlaybackConfigurationInput, options: Options) !PutPlaybackConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediatailor");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutPlaybackConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediatailor", "MediaTailor", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/playbackConfiguration";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.ad_conditioning_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AdConditioningConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ad_decision_server_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AdDecisionServerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ad_decision_server_url) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AdDecisionServerUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.avail_suppression) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AvailSuppression\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.bumper) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Bumper\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.cdn_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"CdnConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.configuration_aliases) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ConfigurationAliases\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.dash_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DashConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.insertion_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"InsertionMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.live_pre_roll_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LivePreRollConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.manifest_processing_rules) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ManifestProcessingRules\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (input.personalization_threshold_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"PersonalizationThresholdSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.slate_ad_url) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SlateAdUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.transcode_profile_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TranscodeProfileName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.video_content_source_url) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"VideoContentSourceUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutPlaybackConfigurationOutput {
    var result: PutPlaybackConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutPlaybackConfigurationOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
