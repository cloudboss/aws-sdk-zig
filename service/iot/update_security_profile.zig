const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricToRetain = @import("metric_to_retain.zig").MetricToRetain;
const AlertTarget = @import("alert_target.zig").AlertTarget;
const Behavior = @import("behavior.zig").Behavior;
const MetricsExportConfig = @import("metrics_export_config.zig").MetricsExportConfig;

pub const UpdateSecurityProfileInput = struct {
    /// *Please use
    /// UpdateSecurityProfileRequest$additionalMetricsToRetainV2
    /// instead.*
    ///
    /// A list of metrics
    /// whose data is retained (stored). By default, data is retained for any metric
    /// used in the profile's `behaviors`, but
    /// it is
    /// also retained for any metric specified here. Can be used with custom
    /// metrics; cannot be used with dimensions.
    additional_metrics_to_retain: ?[]const []const u8 = null,

    /// A list of metrics whose data is retained (stored). By default, data is
    /// retained for any metric used in the profile's behaviors, but it is also
    /// retained for any metric specified here. Can be used with custom metrics;
    /// cannot be used with dimensions.
    additional_metrics_to_retain_v2: ?[]const MetricToRetain = null,

    /// Where the alerts are sent. (Alerts are always sent to the console.)
    alert_targets: ?[]const aws.map.MapEntry(AlertTarget) = null,

    /// Specifies the behaviors that, when violated by a device (thing), cause an
    /// alert.
    behaviors: ?[]const Behavior = null,

    /// If true, delete all `additionalMetricsToRetain` defined for this
    /// security profile. If any `additionalMetricsToRetain` are defined in the
    /// current
    /// invocation, an exception occurs.
    delete_additional_metrics_to_retain: ?bool = null,

    /// If true, delete all `alertTargets` defined for this security profile.
    /// If any `alertTargets` are defined in the current invocation, an exception
    /// occurs.
    delete_alert_targets: ?bool = null,

    /// If true, delete all `behaviors` defined for this security profile.
    /// If any `behaviors` are defined in the current invocation, an exception
    /// occurs.
    delete_behaviors: ?bool = null,

    /// Set the value as true to delete metrics export related configurations.
    delete_metrics_export_config: ?bool = null,

    /// The expected version of the security profile. A new version is generated
    /// whenever
    /// the security profile is updated. If you specify a value that is different
    /// from the actual
    /// version, a `VersionConflictException` is thrown.
    expected_version: ?i64 = null,

    /// Specifies the MQTT topic and role ARN required for metric export.
    metrics_export_config: ?MetricsExportConfig = null,

    /// A description of the security profile.
    security_profile_description: ?[]const u8 = null,

    /// The name of the security profile you want to update.
    security_profile_name: []const u8,

    pub const json_field_names = .{
        .additional_metrics_to_retain = "additionalMetricsToRetain",
        .additional_metrics_to_retain_v2 = "additionalMetricsToRetainV2",
        .alert_targets = "alertTargets",
        .behaviors = "behaviors",
        .delete_additional_metrics_to_retain = "deleteAdditionalMetricsToRetain",
        .delete_alert_targets = "deleteAlertTargets",
        .delete_behaviors = "deleteBehaviors",
        .delete_metrics_export_config = "deleteMetricsExportConfig",
        .expected_version = "expectedVersion",
        .metrics_export_config = "metricsExportConfig",
        .security_profile_description = "securityProfileDescription",
        .security_profile_name = "securityProfileName",
    };
};

pub const UpdateSecurityProfileOutput = struct {
    /// *Please use
    /// UpdateSecurityProfileResponse$additionalMetricsToRetainV2
    /// instead.*
    ///
    /// A list of metrics
    /// whose data is retained (stored). By default, data is retained for any metric
    /// used in the security profile's `behaviors`, but
    /// it is
    /// also retained for any metric specified here.
    additional_metrics_to_retain: ?[]const []const u8 = null,

    /// A list of metrics whose data is retained (stored). By default, data is
    /// retained for any metric used in the profile's behaviors, but it is also
    /// retained for any metric specified here. Can be used with custom metrics;
    /// cannot be used with dimensions.
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

    /// The ARN of the security profile that was updated.
    security_profile_arn: ?[]const u8 = null,

    /// The description of the security profile.
    security_profile_description: ?[]const u8 = null,

    /// The name of the security profile that was updated.
    security_profile_name: ?[]const u8 = null,

    /// The updated version of the security profile.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSecurityProfileInput, options: CallOptions) !UpdateSecurityProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSecurityProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/security-profiles/");
    try path_buf.appendSlice(allocator, input.security_profile_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.expected_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "expectedVersion=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

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
    if (input.delete_additional_metrics_to_retain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deleteAdditionalMetricsToRetain\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.delete_alert_targets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deleteAlertTargets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.delete_behaviors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deleteBehaviors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.delete_metrics_export_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deleteMetricsExportConfig\":");
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

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSecurityProfileOutput {
    var result: UpdateSecurityProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSecurityProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
