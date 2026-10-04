const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Stack = @import("stack.zig").Stack;
const serde = @import("serde.zig");

pub const DescribeStacksInput = struct {
    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// If you don't pass a parameter to `StackName`, the API returns a response
    /// that describes all resources in the account, which can impact performance.
    /// This requires
    /// `ListStacks` and `DescribeStacks` permissions.
    ///
    /// Consider using the ListStacks API if you're not passing a parameter to
    /// `StackName`.
    ///
    /// The IAM policy below can be added to IAM policies when you want to limit
    /// resource-level permissions and avoid returning a response when no parameter
    /// is sent in the
    /// request:
    ///
    /// { "Version": "2012-10-17", "Statement": [{ "Effect": "Deny", "Action":
    /// "cloudformation:DescribeStacks", "NotResource":
    /// "arn:aws:cloudformation:*:*:stack/*/*" }]
    /// }
    ///
    /// The name or the unique stack ID that's associated with the stack, which
    /// aren't always
    /// interchangeable:
    ///
    /// * Running stacks: You can specify either the stack's name or its unique
    ///   stack ID.
    ///
    /// * Deleted stacks: You must specify the unique stack ID.
    stack_name: ?[]const u8 = null,
};

pub const DescribeStacksOutput = struct {
    /// If the output exceeds 1 MB in size, a string that identifies the next page
    /// of stacks. If
    /// no additional page exists, this value is null.
    next_token: ?[]const u8 = null,

    /// A list of stack structures.
    stacks: ?[]const Stack = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStacksInput, options: CallOptions) !DescribeStacksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStacksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeStacks&Version=2010-05-15");
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.stack_name) |v| {
        try body_buf.appendSlice(allocator, "&StackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStacksOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeStacksResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeStacksOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Stacks")) {
                    result.stacks = try serde.deserializeStacks(allocator, &reader, "member");
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
