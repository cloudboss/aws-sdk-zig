const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StackRefactorAction = @import("stack_refactor_action.zig").StackRefactorAction;
const serde = @import("serde.zig");

pub const ListStackRefactorActionsInput = struct {
    /// The maximum number of results to be returned with a single call. If the
    /// number of
    /// available results exceeds this maximum, the response includes a `NextToken`
    /// value
    /// that you can assign to the `NextToken` request parameter to get the next set
    /// of
    /// results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The ID associated with the stack refactor created from the
    /// CreateStackRefactor action.
    stack_refactor_id: []const u8,
};

pub const ListStackRefactorActionsOutput = struct {
    /// If the request doesn't return all the remaining results, `NextToken` is set
    /// to
    /// a token. To retrieve the next set of results, call this action again and
    /// assign that token to
    /// the request object's `NextToken` parameter. If the request returns all
    /// results,
    /// `NextToken` is set to `null`.
    next_token: ?[]const u8 = null,

    /// The stack refactor actions.
    stack_refactor_actions: ?[]const StackRefactorAction = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStackRefactorActionsInput, options: CallOptions) !ListStackRefactorActionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStackRefactorActionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListStackRefactorActions&Version=2010-05-15");
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&StackRefactorId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_refactor_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStackRefactorActionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListStackRefactorActionsResult")) break;
            },
            else => {},
        }
    }

    var result: ListStackRefactorActionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackRefactorActions")) {
                    result.stack_refactor_actions = try serde.deserializeStackRefactorActions(allocator, &reader, "member");
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
