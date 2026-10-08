const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricDestination = @import("metric_destination.zig").MetricDestination;

pub const PutRumMetricsDestinationInput = struct {
    /// The name of the CloudWatch RUM app monitor that will send the metrics.
    app_monitor_name: []const u8,

    /// Defines the destination to send the metrics to. Valid values are
    /// `CloudWatch` and `Evidently`. If you specify `Evidently`, you must also
    /// specify the ARN of the CloudWatchEvidently experiment that is to be the
    /// destination and an IAM role that has permission to write to the experiment.
    destination: MetricDestination,

    /// Use this parameter only if `Destination` is `Evidently`. This parameter
    /// specifies the ARN of the Evidently experiment that will receive the extended
    /// metrics.
    destination_arn: ?[]const u8 = null,

    /// This parameter is required if `Destination` is `Evidently`. If `Destination`
    /// is `CloudWatch`, don't use this parameter.
    ///
    /// This parameter specifies the ARN of an IAM role that RUM will assume to
    /// write to the Evidently experiment that you are sending metrics to. This role
    /// must have permission to write to that experiment.
    ///
    /// If you specify this parameter, you must be signed on to a role that has
    /// [PassRole](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html) permissions attached to it, to allow the role to be passed. The [ CloudWatchAmazonCloudWatchRUMFullAccess](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/auth-and-access-control-cw.html#managed-policies-cloudwatch-RUM) policy doesn't include `PassRole` permissions.
    iam_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_monitor_name = "AppMonitorName",
        .destination = "Destination",
        .destination_arn = "DestinationArn",
        .iam_role_arn = "IamRoleArn",
    };
};

pub const PutRumMetricsDestinationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRumMetricsDestinationInput, options: CallOptions) !PutRumMetricsDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rum", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRumMetricsDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rum", "RUM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/rummetrics/");
    try path_buf.appendSlice(allocator, input.app_monitor_name);
    try path_buf.appendSlice(allocator, "/metricsdestination");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, allocator, &body_buf);
    has_prev = true;
    if (input.destination_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.iam_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IamRoleArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRumMetricsDestinationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutRumMetricsDestinationOutput = .{};

    return result;
}
