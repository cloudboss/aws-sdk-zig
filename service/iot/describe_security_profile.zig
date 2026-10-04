const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricToRetain = @import("metric_to_retain.zig").MetricToRetain;
const AlertTarget = @import("alert_target.zig").AlertTarget;
const Behavior = @import("behavior.zig").Behavior;
const MetricsExportConfig = @import("metrics_export_config.zig").MetricsExportConfig;

pub const DescribeSecurityProfileInput = struct {
    /// The name of the security profile
    /// whose information you want to get.
    security_profile_name: []const u8,

    pub const json_field_names = .{
        .security_profile_name = "securityProfileName",
    };
};

pub const DescribeSecurityProfileOutput = struct {
    /// *Please use
    /// DescribeSecurityProfileResponse$additionalMetricsToRetainV2
    /// instead.*
    ///
    /// A list of metrics
    /// whose data is retained (stored). By default, data is retained for any metric
    /// used in the profile's `behaviors`, but
    /// it is
    /// also retained for any metric specified here.
    additional_metrics_to_retain: ?[]const []const u8 = null,

    /// A list of metrics whose data is retained (stored). By default, data is
    /// retained for any
    /// metric used in the profile's behaviors, but
    /// it is
    /// also retained for any metric specified here.
    additional_metrics_to_retain_v2: ?[]const MetricToRetain = null,

    /// Where the alerts are sent. (Alerts are always sent to the console.)
    alert_targets: ?[]const aws.map.MapEntry(AlertTarget) = null,

    /// Specifies the behaviors that, when violated by a device (thing), cause an
    /// alert.
    behaviors: ?[]const Behavior = null,

    /// The time the security profile was created.
    creation_date: ?i64 = null,

    /// The time the security profile was last modified.
    last_modified_date: ?i64 = null,

    /// Specifies the MQTT topic and role ARN required for metric export.
    metrics_export_config: ?MetricsExportConfig = null,

    /// The ARN of the security profile.
    security_profile_arn: ?[]const u8 = null,

    /// A description of the security profile (associated with the security profile
    /// when it was created or updated).
    security_profile_description: ?[]const u8 = null,

    /// The name of the security profile.
    security_profile_name: ?[]const u8 = null,

    /// The version of the security profile. A new version is generated whenever the
    /// security profile is updated.
    version: ?i64 = null,

    pub const json_field_names = .{
        .additional_metrics_to_retain = "additionalMetricsToRetain",
        .additional_metrics_to_retain_v2 = "additionalMetricsToRetainV2",
        .alert_targets = "alertTargets",
        .behaviors = "behaviors",
        .creation_date = "creationDate",
        .last_modified_date = "lastModifiedDate",
        .metrics_export_config = "metricsExportConfig",
        .security_profile_arn = "securityProfileArn",
        .security_profile_description = "securityProfileDescription",
        .security_profile_name = "securityProfileName",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSecurityProfileInput, options: CallOptions) !DescribeSecurityProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSecurityProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/security-profiles/");
    try path_buf.appendSlice(allocator, input.security_profile_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSecurityProfileOutput {
    const result: DescribeSecurityProfileOutput = try aws.json.parseJsonObject(
        DescribeSecurityProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
