const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricDestination = @import("metric_destination.zig").MetricDestination;

pub const DeleteRumMetricsDestinationInput = struct {
    /// The name of the app monitor that is sending metrics to the destination that
    /// you want to delete.
    app_monitor_name: []const u8,

    /// The type of destination to delete. Valid values are `CloudWatch` and
    /// `Evidently`.
    destination: MetricDestination,

    /// This parameter is required if `Destination` is `Evidently`. If `Destination`
    /// is `CloudWatch`, do not use this parameter. This parameter specifies the ARN
    /// of the Evidently experiment that corresponds to the destination to delete.
    destination_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_monitor_name = "AppMonitorName",
        .destination = "Destination",
        .destination_arn = "DestinationArn",
    };
};

pub const DeleteRumMetricsDestinationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRumMetricsDestinationInput, options: CallOptions) !DeleteRumMetricsDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRumMetricsDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rum", "RUM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/rummetrics/");
    try path_buf.appendSlice(allocator, input.app_monitor_name);
    try path_buf.appendSlice(allocator, "/metricsdestination");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "destination=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.destination.wireName());
    query_has_prev = true;
    if (input.destination_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "destinationArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRumMetricsDestinationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteRumMetricsDestinationOutput = .{};

    return result;
}
