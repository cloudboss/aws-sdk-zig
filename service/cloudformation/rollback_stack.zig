const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RollbackStackInput = struct {
    /// A unique identifier for this `RollbackStack` request.
    client_request_token: ?[]const u8 = null,

    /// When set to `true`, newly created resources are deleted when the operation
    /// rolls back. This includes newly created resources marked with a deletion
    /// policy of
    /// `Retain`.
    ///
    /// Default: `false`
    retain_except_on_create: ?bool = null,

    /// The Amazon Resource Name (ARN) of an IAM role that CloudFormation assumes to
    /// rollback the
    /// stack.
    role_arn: ?[]const u8 = null,

    /// The name that's associated with the stack.
    stack_name: []const u8,
};

pub const RollbackStackOutput = struct {
    /// A unique identifier for this rollback operation that can be used to track
    /// the operation's
    /// progress and events.
    operation_id: ?[]const u8 = null,

    /// Unique identifier of the stack.
    stack_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RollbackStackInput, options: CallOptions) !RollbackStackOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RollbackStackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RollbackStack&Version=2010-05-15");
    if (input.client_request_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientRequestToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.retain_except_on_create) |v| {
        try body_buf.appendSlice(allocator, "&RetainExceptOnCreate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.role_arn) |v| {
        try body_buf.appendSlice(allocator, "&RoleARN=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RollbackStackOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RollbackStackResult")) break;
            },
            else => {},
        }
    }

    var result: RollbackStackOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
