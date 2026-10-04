const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionRedriveFilter = @import("execution_redrive_filter.zig").ExecutionRedriveFilter;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const ExecutionListItem = @import("execution_list_item.zig").ExecutionListItem;

pub const ListExecutionsInput = struct {
    /// The Amazon Resource Name (ARN) of the Map Run that started the child
    /// workflow executions. If the `mapRunArn` field is specified, a list of all of
    /// the child workflow executions started by a Map Run is returned. For more
    /// information, see [Examining Map
    /// Run](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-examine-map-run.html) in the *Step Functions Developer Guide*.
    ///
    /// You can specify either a `mapRunArn` or a `stateMachineArn`, but not both.
    map_run_arn: ?[]const u8 = null,

    /// The maximum number of results that are returned per call. You can use
    /// `nextToken` to obtain further pages of results.
    /// The default is 100 and the maximum allowed page size is 1000. A value of 0
    /// uses the default.
    ///
    /// This is only an upper limit. The actual number of results returned per call
    /// might be fewer than the specified maximum.
    max_results: ?i32 = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    next_token: ?[]const u8 = null,

    /// Sets a filter to list executions based on whether or not they have been
    /// redriven.
    ///
    /// For a Distributed Map, `redriveFilter` sets a filter to list child workflow
    /// executions based on whether or not they have been redriven.
    ///
    /// If you do not provide a `redriveFilter`, Step Functions returns a list of
    /// both redriven and non-redriven executions.
    ///
    /// If you provide a state machine ARN in `redriveFilter`, the API returns a
    /// validation exception.
    redrive_filter: ?ExecutionRedriveFilter = null,

    /// The Amazon Resource Name (ARN) of the state machine whose executions is
    /// listed.
    ///
    /// You can specify either a `mapRunArn` or a `stateMachineArn`, but not both.
    ///
    /// You can also return a list of executions associated with a specific
    /// [alias](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html) or [version](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html), by specifying an alias ARN or a version ARN in the `stateMachineArn` parameter.
    state_machine_arn: ?[]const u8 = null,

    /// If specified, only list the executions whose current execution status
    /// matches the given
    /// filter.
    ///
    /// If you provide a `PENDING_REDRIVE` statusFilter, you must specify
    /// `mapRunArn`.
    /// For more information, see [Child workflow execution redrive
    /// behaviour](https://docs.aws.amazon.com/step-functions/latest/dg/redrive-map-run.html#redrive-child-workflow-behavior)
    /// in the *Step Functions Developer Guide*.
    ///
    /// If you provide a stateMachineArn and a `PENDING_REDRIVE` statusFilter, the
    /// API returns a validation exception.
    status_filter: ?ExecutionStatus = null,

    pub const json_field_names = .{
        .map_run_arn = "mapRunArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .redrive_filter = "redriveFilter",
        .state_machine_arn = "stateMachineArn",
        .status_filter = "statusFilter",
    };
};

pub const ListExecutionsOutput = struct {
    /// The list of matching executions.
    executions: ?[]const ExecutionListItem = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .executions = "executions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExecutionsInput, options: CallOptions) !ListExecutionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExecutionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.ListExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExecutionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListExecutionsOutput, body, allocator);
}
