const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetKxUserInput = struct {
    /// A unique identifier for the kdb environment.
    environment_id: []const u8,

    /// A unique identifier for the user.
    user_name: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .user_name = "userName",
    };
};

pub const GetKxUserOutput = struct {
    /// A unique identifier for the kdb environment.
    environment_id: ?[]const u8 = null,

    /// The IAM role ARN that is associated with the user.
    iam_role: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the user. For more
    /// information about ARNs and
    /// how to use ARNs in policies, see [IAM
    /// Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) in the
    /// *IAM User Guide*.
    user_arn: ?[]const u8 = null,

    /// A unique identifier for the user.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .iam_role = "iamRole",
        .user_arn = "userArn",
        .user_name = "userName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKxUserInput, options: CallOptions) !GetKxUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKxUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.user_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKxUserOutput {
    const result: GetKxUserOutput = try aws.json.parseJsonObject(
        GetKxUserOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
