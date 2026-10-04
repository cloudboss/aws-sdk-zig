const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionStatus = @import("action_status.zig").ActionStatus;
const ManagedAction = @import("managed_action.zig").ManagedAction;
const serde = @import("serde.zig");

pub const DescribeEnvironmentManagedActionsInput = struct {
    /// The environment ID of the target environment.
    environment_id: ?[]const u8 = null,

    /// The name of the target environment.
    environment_name: ?[]const u8 = null,

    /// To show only actions with a particular status, specify a status.
    status: ?ActionStatus = null,
};

pub const DescribeEnvironmentManagedActionsOutput = struct {
    /// A list of upcoming and in-progress managed actions.
    managed_actions: ?[]const ManagedAction = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEnvironmentManagedActionsInput, options: CallOptions) !DescribeEnvironmentManagedActionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticbeanstalk", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEnvironmentManagedActionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEnvironmentManagedActions&Version=2010-12-01");
    if (input.environment_id) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.status) |v| {
        try body_buf.appendSlice(allocator, "&Status=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEnvironmentManagedActionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEnvironmentManagedActionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEnvironmentManagedActionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ManagedActions")) {
                    result.managed_actions = try serde.deserializeManagedActions(allocator, &reader, "member");
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
