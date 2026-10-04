const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteAccessPointPolicyForObjectLambdaInput = struct {
    /// The account ID for the account that owns the specified Object Lambda Access
    /// Point.
    account_id: []const u8,

    /// The name of the Object Lambda Access Point you want to delete the policy
    /// for.
    name: []const u8,
};

pub const DeleteAccessPointPolicyForObjectLambdaOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAccessPointPolicyForObjectLambdaInput, options: CallOptions) !DeleteAccessPointPolicyForObjectLambdaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAccessPointPolicyForObjectLambdaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/accesspointforobjectlambda/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAccessPointPolicyForObjectLambdaOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteAccessPointPolicyForObjectLambdaOutput = .{};

    return result;
}
