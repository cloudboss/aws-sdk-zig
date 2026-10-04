const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeSetHook = @import("change_set_hook.zig").ChangeSetHook;
const ChangeSetHooksStatus = @import("change_set_hooks_status.zig").ChangeSetHooksStatus;
const serde = @import("serde.zig");

pub const DescribeChangeSetHooksInput = struct {
    /// The name or Amazon Resource Name (ARN) of the change set that you want to
    /// describe.
    change_set_name: []const u8,

    /// If specified, lists only the Hooks related to the specified
    /// `LogicalResourceId`.
    logical_resource_id: ?[]const u8 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// If you specified the name of a change set, specify the stack name or stack
    /// ID (ARN) of the
    /// change set you want to describe.
    stack_name: ?[]const u8 = null,
};

pub const DescribeChangeSetHooksOutput = struct {
    /// The change set identifier (stack ID).
    change_set_id: ?[]const u8 = null,

    /// The change set name.
    change_set_name: ?[]const u8 = null,

    /// List of Hook objects.
    hooks: ?[]const ChangeSetHook = null,

    /// Pagination token, `null` or empty if no more results.
    next_token: ?[]const u8 = null,

    /// The stack identifier (stack ID).
    stack_id: ?[]const u8 = null,

    /// The stack name.
    stack_name: ?[]const u8 = null,

    /// Provides the status of the change set Hook.
    status: ?ChangeSetHooksStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeChangeSetHooksInput, options: CallOptions) !DescribeChangeSetHooksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeChangeSetHooksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeChangeSetHooks&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&ChangeSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.change_set_name);
    if (input.logical_resource_id) |v| {
        try body_buf.appendSlice(allocator, "&LogicalResourceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeChangeSetHooksOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeChangeSetHooksResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeChangeSetHooksOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChangeSetId")) {
                    result.change_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChangeSetName")) {
                    result.change_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Hooks")) {
                    result.hooks = try serde.deserializeChangeSetHooks(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ChangeSetHooksStatus.fromWireName(try reader.readElementText());
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
