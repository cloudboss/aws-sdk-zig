const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ManagedActionHistoryItem = @import("managed_action_history_item.zig").ManagedActionHistoryItem;
const serde = @import("serde.zig");

pub const DescribeEnvironmentManagedActionHistoryInput = struct {
    /// The environment ID of the target environment.
    environment_id: ?[]const u8 = null,

    /// The name of the target environment.
    environment_name: ?[]const u8 = null,

    /// The maximum number of items to return for a single request.
    max_items: ?i32 = null,

    /// The pagination token returned by a previous request.
    next_token: ?[]const u8 = null,
};

pub const DescribeEnvironmentManagedActionHistoryOutput = struct {
    /// A list of completed and failed managed actions.
    managed_action_history_items: ?[]const ManagedActionHistoryItem = null,

    /// A pagination token that you pass to DescribeEnvironmentManagedActionHistory
    /// to get the next page of results.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEnvironmentManagedActionHistoryInput, options: CallOptions) !DescribeEnvironmentManagedActionHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEnvironmentManagedActionHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEnvironmentManagedActionHistory&Version=2010-12-01");
    if (input.environment_id) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_items) |v| {
        try body_buf.appendSlice(allocator, "&MaxItems=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEnvironmentManagedActionHistoryOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEnvironmentManagedActionHistoryResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEnvironmentManagedActionHistoryOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ManagedActionHistoryItems")) {
                    result.managed_action_history_items = try serde.deserializeManagedActionHistoryItems(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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
