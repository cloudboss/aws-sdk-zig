const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowExecutionFilter = @import("workflow_execution_filter.zig").WorkflowExecutionFilter;
const ExecutionTimeFilter = @import("execution_time_filter.zig").ExecutionTimeFilter;
const TagFilter = @import("tag_filter.zig").TagFilter;
const WorkflowTypeFilter = @import("workflow_type_filter.zig").WorkflowTypeFilter;

pub const CountOpenWorkflowExecutionsInput = struct {
    /// The name of the domain containing the workflow executions to count.
    domain: []const u8,

    /// If specified, only workflow executions matching the `WorkflowId` in the
    /// filter are counted.
    ///
    /// `executionFilter`, `typeFilter` and `tagFilter` are
    /// mutually exclusive. You can specify at most one of these in a request.
    execution_filter: ?WorkflowExecutionFilter = null,

    /// Specifies the start time criteria that workflow executions must meet in
    /// order to be
    /// counted.
    start_time_filter: ExecutionTimeFilter,

    /// If specified, only executions that have a tag that matches the filter are
    /// counted.
    ///
    /// `executionFilter`, `typeFilter` and `tagFilter` are
    /// mutually exclusive. You can specify at most one of these in a request.
    tag_filter: ?TagFilter = null,

    /// Specifies the type of the workflow executions to be counted.
    ///
    /// `executionFilter`, `typeFilter` and `tagFilter` are
    /// mutually exclusive. You can specify at most one of these in a request.
    type_filter: ?WorkflowTypeFilter = null,

    pub const json_field_names = .{
        .domain = "domain",
        .execution_filter = "executionFilter",
        .start_time_filter = "startTimeFilter",
        .tag_filter = "tagFilter",
        .type_filter = "typeFilter",
    };
};

pub const CountOpenWorkflowExecutionsOutput = struct {
    /// The number of workflow executions.
    count: ?i32 = null,

    /// If set to true, indicates that the actual count was more than the maximum
    /// supported by this API and the count returned is the truncated value.
    truncated: ?bool = null,

    pub const json_field_names = .{
        .count = "count",
        .truncated = "truncated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CountOpenWorkflowExecutionsInput, options: CallOptions) !CountOpenWorkflowExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CountOpenWorkflowExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.CountOpenWorkflowExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CountOpenWorkflowExecutionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CountOpenWorkflowExecutionsOutput, body, allocator);
}
