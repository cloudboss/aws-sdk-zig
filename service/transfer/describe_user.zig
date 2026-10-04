const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribedUser = @import("described_user.zig").DescribedUser;

pub const DescribeUserInput = struct {
    /// A system-assigned unique identifier for a server that has this user
    /// assigned.
    server_id: []const u8,

    /// The name of the user assigned to one or more servers. User names are part of
    /// the sign-in credentials to use the Transfer Family service and perform file
    /// transfer tasks.
    user_name: []const u8,

    pub const json_field_names = .{
        .server_id = "ServerId",
        .user_name = "UserName",
    };
};

pub const DescribeUserOutput = struct {
    /// A system-assigned unique identifier for a server that has this user
    /// assigned.
    server_id: []const u8,

    /// An array containing the properties of the Transfer Family user for the
    /// `ServerID` value that you specified.
    user: ?DescribedUser = null,

    pub const json_field_names = .{
        .server_id = "ServerId",
        .user = "User",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUserInput, options: CallOptions) !DescribeUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUserInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.DescribeUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUserOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeUserOutput, body, allocator);
}
