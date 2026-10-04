const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MapRunExecutionCounts = @import("map_run_execution_counts.zig").MapRunExecutionCounts;
const MapRunItemCounts = @import("map_run_item_counts.zig").MapRunItemCounts;
const MapRunStatus = @import("map_run_status.zig").MapRunStatus;

pub const DescribeMapRunInput = struct {
    /// The Amazon Resource Name (ARN) that identifies a Map Run.
    map_run_arn: []const u8,

    pub const json_field_names = .{
        .map_run_arn = "mapRunArn",
    };
};

pub const DescribeMapRunOutput = struct {
    /// The Amazon Resource Name (ARN) that identifies the execution in which the
    /// Map Run was started.
    execution_arn: []const u8,

    /// A JSON object that contains information about the total number of child
    /// workflow executions for the Map Run, and the count of child workflow
    /// executions for each status, such as `failed` and `succeeded`.
    execution_counts: ?MapRunExecutionCounts = null,

    /// A JSON object that contains information about the total number of items, and
    /// the item count for each processing status, such as `pending` and `failed`.
    item_counts: ?MapRunItemCounts = null,

    /// The Amazon Resource Name (ARN) that identifies a Map Run.
    map_run_arn: []const u8,

    /// The maximum number of child workflow executions configured to run in
    /// parallel for the Map Run at the same time.
    max_concurrency: ?i32 = null,

    /// The number of times you've redriven a Map Run. If you have not yet redriven
    /// a Map Run, the `redriveCount` is 0. This count is only updated if you
    /// successfully redrive a Map Run.
    redrive_count: ?i32 = null,

    /// The date a Map Run was last redriven. If you have not yet redriven a Map
    /// Run, the `redriveDate` is null.
    redrive_date: ?i64 = null,

    /// The date when the Map Run was started.
    start_date: i64,

    /// The current status of the Map Run.
    status: MapRunStatus,

    /// The date when the Map Run was stopped.
    stop_date: ?i64 = null,

    /// The maximum number of failed child workflow executions before the Map Run
    /// fails.
    tolerated_failure_count: ?i64 = null,

    /// The maximum percentage of failed child workflow executions before the Map
    /// Run fails.
    tolerated_failure_percentage: ?f32 = null,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .execution_counts = "executionCounts",
        .item_counts = "itemCounts",
        .map_run_arn = "mapRunArn",
        .max_concurrency = "maxConcurrency",
        .redrive_count = "redriveCount",
        .redrive_date = "redriveDate",
        .start_date = "startDate",
        .status = "status",
        .stop_date = "stopDate",
        .tolerated_failure_count = "toleratedFailureCount",
        .tolerated_failure_percentage = "toleratedFailurePercentage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMapRunInput, options: CallOptions) !DescribeMapRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "states", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMapRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.DescribeMapRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMapRunOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeMapRunOutput, body, allocator);
}
