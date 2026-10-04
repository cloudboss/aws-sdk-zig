const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortOrderType = @import("sort_order_type.zig").SortOrderType;
const CommandExecution = @import("command_execution.zig").CommandExecution;

pub const ListCommandExecutionsForSandboxInput = struct {
    /// The maximum number of sandbox records to be retrieved.
    max_results: ?i32 = null,

    /// The next token, if any, to get paginated results. You will get this value
    /// from previous execution of list sandboxes.
    next_token: ?[]const u8 = null,

    /// A `sandboxId` or `sandboxArn`.
    sandbox_id: []const u8,

    /// The order in which sandbox records should be retrieved.
    sort_order: ?SortOrderType = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sandbox_id = "sandboxId",
        .sort_order = "sortOrder",
    };
};

pub const ListCommandExecutionsForSandboxOutput = struct {
    /// Information about the requested command executions.
    command_executions: ?[]const CommandExecution = null,

    /// Information about the next token to get paginated results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_executions = "commandExecutions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCommandExecutionsForSandboxInput, options: CallOptions) !ListCommandExecutionsForSandboxOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCommandExecutionsForSandboxInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.ListCommandExecutionsForSandbox");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCommandExecutionsForSandboxOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCommandExecutionsForSandboxOutput, body, allocator);
}
