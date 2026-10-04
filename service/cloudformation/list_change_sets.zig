const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeSetSummary = @import("change_set_summary.zig").ChangeSetSummary;
const serde = @import("serde.zig");

pub const ListChangeSetsInput = struct {
    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The name or the Amazon Resource Name (ARN) of the stack for which you want
    /// to list change
    /// sets.
    stack_name: []const u8,
};

pub const ListChangeSetsOutput = struct {
    /// If the output exceeds 1 MB, a string that identifies the next page of change
    /// sets. If
    /// there is no additional page, this value is `null`.
    next_token: ?[]const u8 = null,

    /// A list of `ChangeSetSummary` structures that provides the ID and status of
    /// each
    /// change set for the specified stack.
    summaries: ?[]const ChangeSetSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListChangeSetsInput, options: CallOptions) !ListChangeSetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChangeSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListChangeSets&Version=2010-05-15");
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChangeSetsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListChangeSetsResult")) break;
            },
            else => {},
        }
    }

    var result: ListChangeSetsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Summaries")) {
                    result.summaries = try serde.deserializeChangeSetSummaries(allocator, &reader, "member");
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
