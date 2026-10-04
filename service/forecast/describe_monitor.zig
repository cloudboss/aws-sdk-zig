const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Baseline = @import("baseline.zig").Baseline;

pub const DescribeMonitorInput = struct {
    /// The Amazon Resource Name (ARN) of the monitor resource to describe.
    monitor_arn: []const u8,

    pub const json_field_names = .{
        .monitor_arn = "MonitorArn",
    };
};

pub const DescribeMonitorOutput = struct {
    /// Metrics you can use as a baseline for comparison purposes. Use these values
    /// you interpret monitoring results for an auto predictor.
    baseline: ?Baseline = null,

    /// The timestamp for when the monitor resource was created.
    creation_time: ?i64 = null,

    /// The estimated number of minutes remaining before the monitor resource
    /// finishes its current evaluation.
    estimated_evaluation_time_remaining_in_minutes: ?i64 = null,

    /// The state of the monitor's latest evaluation.
    last_evaluation_state: ?[]const u8 = null,

    /// The timestamp of the latest evaluation completed by the monitor.
    last_evaluation_time: ?i64 = null,

    /// The timestamp of the latest modification to the monitor.
    last_modification_time: ?i64 = null,

    /// An error message, if any, for the monitor.
    message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the monitor resource described.
    monitor_arn: ?[]const u8 = null,

    /// The name of the monitor.
    monitor_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the auto predictor being monitored.
    resource_arn: ?[]const u8 = null,

    /// The status of the monitor resource.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .baseline = "Baseline",
        .creation_time = "CreationTime",
        .estimated_evaluation_time_remaining_in_minutes = "EstimatedEvaluationTimeRemainingInMinutes",
        .last_evaluation_state = "LastEvaluationState",
        .last_evaluation_time = "LastEvaluationTime",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .monitor_arn = "MonitorArn",
        .monitor_name = "MonitorName",
        .resource_arn = "ResourceArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMonitorInput, options: CallOptions) !DescribeMonitorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "forecast", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMonitorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribeMonitor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMonitorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMonitorOutput, body, allocator);
}
