const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricToRetain = @import("metric_to_retain.zig").MetricToRetain;
const AlertTarget = @import("alert_target.zig").AlertTarget;
const Behavior = @import("behavior.zig").Behavior;
const MetricsExportConfig = @import("metrics_export_config.zig").MetricsExportConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateSecurityProfileInput = struct {
    /// *Please use CreateSecurityProfileRequest$additionalMetricsToRetainV2
    /// instead.*
    ///
    /// A list of metrics whose data is retained (stored). By default, data is
    /// retained
    /// for any metric used in the profile's `behaviors`, but it is also retained
    /// for
    /// any metric specified here. Can be used with custom metrics; cannot be used
    /// with dimensions.
    additional_metrics_to_retain: ?[]const []const u8 = null,

    /// A list of metrics whose data is retained (stored). By default, data is
    /// retained for any metric used in the profile's `behaviors`, but it is also
    /// retained for any metric specified here. Can be used with custom metrics;
    /// cannot be used with dimensions.
    additional_metrics_to_retain_v2: ?[]const MetricToRetain = null,

    /// Specifies the destinations to which alerts are sent. (Alerts are always sent
    /// to the
    /// console.) Alerts are generated when a device (thing) violates a behavior.
    alert_targets: ?[]const aws.map.MapEntry(AlertTarget) = null,

    /// Specifies the behaviors that, when violated by a device (thing), cause an
    /// alert.
    behaviors: ?[]const Behavior = null,

    /// Specifies the MQTT topic and role ARN required for metric export.
    metrics_export_config: ?MetricsExportConfig = null,

    /// A description of the security profile.
    security_profile_description: ?[]const u8 = null,

    /// The name you are giving to the security profile.
    security_profile_name: []const u8,

    /// Metadata that can be used to manage the security profile.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .additional_metrics_to_retain = "additionalMetricsToRetain",
        .additional_metrics_to_retain_v2 = "additionalMetricsToRetainV2",
        .alert_targets = "alertTargets",
        .behaviors = "behaviors",
        .metrics_export_config = "metricsExportConfig",
        .security_profile_description = "securityProfileDescription",
        .security_profile_name = "securityProfileName",
        .tags = "tags",
    };
};

pub const CreateSecurityProfileOutput = struct {
    /// The ARN of the security profile.
    security_profile_arn: ?[]const u8 = null,

    /// The name you gave to the security profile.
    security_profile_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .security_profile_arn = "securityProfileArn",
        .security_profile_name = "securityProfileName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSecurityProfileInput, options: CallOptions) !CreateSecurityProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSecurityProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/security-profiles/");
    try path_buf.appendSlice(allocator, input.security_profile_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_metrics_to_retain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalMetricsToRetain\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.additional_metrics_to_retain_v2) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalMetricsToRetainV2\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.alert_targets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alertTargets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.behaviors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"behaviors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metrics_export_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metricsExportConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.security_profile_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"securityProfileDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSecurityProfileOutput {
    var result: CreateSecurityProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSecurityProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
