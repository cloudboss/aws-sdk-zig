const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommandFilter = @import("command_filter.zig").CommandFilter;
const Command = @import("command.zig").Command;

pub const ListCommandsInput = struct {
    /// (Optional) If provided, lists only the specified command.
    command_id: ?[]const u8 = null,

    /// (Optional) One or more filters. Use a filter to return a more specific list
    /// of results.
    filters: ?[]const CommandFilter = null,

    /// (Optional) Lists commands issued against this managed node ID.
    ///
    /// You can't specify a managed node ID in the same command that you specify
    /// `Status` = `Pending`. This is because the command hasn't reached the
    /// managed node yet.
    instance_id: ?[]const u8 = null,

    /// (Optional) The maximum number of items to return for this call. The call
    /// also returns a
    /// token that you can specify in a subsequent call to get the next set of
    /// results.
    max_results: ?i32 = null,

    /// (Optional) The token for the next set of items to return. (You received this
    /// token from a
    /// previous call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_id = "CommandId",
        .filters = "Filters",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListCommandsOutput = struct {
    /// (Optional) The list of commands requested by the user.
    commands: ?[]const Command = null,

    /// (Optional) The token for the next set of items to return. (You received this
    /// token from a
    /// previous call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .commands = "Commands",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCommandsInput, options: CallOptions) !ListCommandsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCommandsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.ListCommands");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCommandsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCommandsOutput, body, allocator);
}
