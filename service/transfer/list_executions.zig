const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListedExecution = @import("listed_execution.zig").ListedExecution;

pub const ListExecutionsInput = struct {
    /// The maximum number of items to return.
    max_results: ?i32 = null,

    /// `ListExecutions` returns the `NextToken` parameter in the output. You can
    /// then pass the `NextToken` parameter in a subsequent command to continue
    /// listing additional executions.
    ///
    /// This is useful for pagination, for instance. If you have 100 executions for
    /// a workflow, you might only want to list first 10. If so, call the API by
    /// specifying the `max-results`:
    ///
    /// `aws transfer list-executions --max-results 10`
    ///
    /// This returns details for the first 10 executions, as well as the pointer
    /// (`NextToken`) to the eleventh execution. You can now call the API again,
    /// supplying the `NextToken` value you received:
    ///
    /// `aws transfer list-executions --max-results 10 --next-token
    /// $somePointerReturnedFromPreviousListResult`
    ///
    /// This call returns the next 10 executions, the 11th through the 20th. You can
    /// then repeat the call until the details for all 100 executions have been
    /// returned.
    next_token: ?[]const u8 = null,

    /// A unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .workflow_id = "WorkflowId",
    };
};

pub const ListExecutionsOutput = struct {
    /// Returns the details for each execution, in a `ListedExecution` array.
    executions: ?[]const ListedExecution = null,

    /// `ListExecutions` returns the `NextToken` parameter in the output. You can
    /// then pass the `NextToken` parameter in a subsequent command to continue
    /// listing additional executions.
    next_token: ?[]const u8 = null,

    /// A unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .executions = "Executions",
        .next_token = "NextToken",
        .workflow_id = "WorkflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExecutionsInput, options: CallOptions) !ListExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.ListExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExecutionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListExecutionsOutput, body, allocator);
}
