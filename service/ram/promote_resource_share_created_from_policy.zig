const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PromoteResourceShareCreatedFromPolicyInput = struct {
    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share to promote.
    resource_share_arn: []const u8,

    pub const json_field_names = .{
        .resource_share_arn = "resourceShareArn",
    };
};

pub const PromoteResourceShareCreatedFromPolicyOutput = struct {
    /// A return value of `true` indicates that the request succeeded.
    /// A value of `false` indicates that the request failed.
    return_value: ?bool = null,

    pub const json_field_names = .{
        .return_value = "returnValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PromoteResourceShareCreatedFromPolicyInput, options: CallOptions) !PromoteResourceShareCreatedFromPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ram", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PromoteResourceShareCreatedFromPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/promoteresourcesharecreatedfrompolicy";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceShareArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_share_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PromoteResourceShareCreatedFromPolicyOutput {
    const result: PromoteResourceShareCreatedFromPolicyOutput = try aws.json.parseJsonObject(
        PromoteResourceShareCreatedFromPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
