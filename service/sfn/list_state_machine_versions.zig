const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StateMachineVersionListItem = @import("state_machine_version_list_item.zig").StateMachineVersionListItem;

pub const ListStateMachineVersionsInput = struct {
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

    /// The Amazon Resource Name (ARN) of the state machine.
    state_machine_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .state_machine_arn = "stateMachineArn",
    };
};

pub const ListStateMachineVersionsOutput = struct {
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    next_token: ?[]const u8 = null,

    /// Versions for the state machine.
    state_machine_versions: ?[]const StateMachineVersionListItem = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .state_machine_versions = "stateMachineVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStateMachineVersionsInput, options: CallOptions) !ListStateMachineVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStateMachineVersionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.ListStateMachineVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStateMachineVersionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListStateMachineVersionsOutput, body, allocator);
}
