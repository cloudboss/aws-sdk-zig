const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const ResolveTo = @import("resolve_to.zig").ResolveTo;
const TargetResource = @import("target_resource.zig").TargetResource;

pub const DescribeExecutionInput = struct {
    /// The ID of the execution.
    execution_id: []const u8,

    pub const json_field_names = .{
        .execution_id = "executionId",
    };
};

pub const DescribeExecutionOutput = struct {
    /// The type of action exectued.
    action_type: ?[]const u8 = null,

    /// Provides detailed information about the execution of your anomaly detection
    /// models. This
    /// includes model metrics and training timestamps for both training and
    /// inference actions.
    ///
    /// * The training action (Amazon Web Services/ANOMALY_DETECTION_TRAINING),
    ///   includes performance metrics
    /// that help you compare different versions of your anomaly detection models.
    /// These metrics
    /// provide insights into the model's performance during the training process.
    ///
    /// * The inference action (Amazon Web Services/ANOMALY_DETECTION_INFERENCE),
    ///   includes information about
    /// the results of executing your anomaly detection models. This helps you
    /// understand the
    /// output of your models and assess their performance.
    execution_details: ?[]const aws.map.StringMapEntry = null,

    /// The time the process ended.
    execution_end_time: ?i64 = null,

    /// Entity version used for the execution.
    execution_entity_version: ?[]const u8 = null,

    /// The ID of the execution.
    execution_id: []const u8,

    /// The result of the execution.
    execution_result: ?[]const aws.map.StringMapEntry = null,

    /// The time the process started.
    execution_start_time: i64,

    /// The status of the execution process.
    execution_status: ?ExecutionStatus = null,

    /// The detailed resource this execution resolves to.
    resolve_to: ?ResolveTo = null,

    target_resource: ?TargetResource = null,

    /// The version of the target resource.
    target_resource_version: []const u8,

    pub const json_field_names = .{
        .action_type = "actionType",
        .execution_details = "executionDetails",
        .execution_end_time = "executionEndTime",
        .execution_entity_version = "executionEntityVersion",
        .execution_id = "executionId",
        .execution_result = "executionResult",
        .execution_start_time = "executionStartTime",
        .execution_status = "executionStatus",
        .resolve_to = "resolveTo",
        .target_resource = "targetResource",
        .target_resource_version = "targetResourceVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeExecutionInput, options: CallOptions) !DescribeExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/executions/");
    try path_buf.appendSlice(allocator, input.execution_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeExecutionOutput {
    const result: DescribeExecutionOutput = try aws.json.parseJsonObject(
        DescribeExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
