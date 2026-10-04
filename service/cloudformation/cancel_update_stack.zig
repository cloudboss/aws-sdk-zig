const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CancelUpdateStackInput = struct {
    /// A unique identifier for this `CancelUpdateStack` request. Specify this token
    /// if
    /// you plan to retry requests so that CloudFormation knows that you're not
    /// attempting to cancel an
    /// update on a stack with the same name. You might retry `CancelUpdateStack`
    /// requests
    /// to ensure that CloudFormation successfully received them.
    client_request_token: ?[]const u8 = null,

    /// If you don't pass a parameter to `StackName`, the API returns a response
    /// that
    /// describes all resources in the account.
    ///
    /// The IAM policy below can be added to IAM policies when you want to limit
    /// resource-level permissions and avoid returning a response when no parameter
    /// is sent in the
    /// request:
    ///
    /// `{ "Version": "2012-10-17", "Statement": [{ "Effect": "Deny",
    /// "Action": "cloudformation:DescribeStacks", "NotResource":
    /// "arn:aws:cloudformation:*:*:stack/*/*" }] }`
    ///
    /// The name or the unique stack ID that's associated with the stack.
    stack_name: []const u8,
};

pub const CancelUpdateStackOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelUpdateStackInput, options: CallOptions) !CancelUpdateStackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelUpdateStackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CancelUpdateStack&Version=2010-05-15");
    if (input.client_request_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientRequestToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&StackName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelUpdateStackOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CancelUpdateStackOutput = .{};

    return result;
}
