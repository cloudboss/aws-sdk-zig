const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteTargetInput = struct {
    /// A Boolean value that can be used to delete all associations with this Amazon
    /// Q Developer in chat applications topic. The
    /// default value is FALSE. If set to TRUE, all associations between that target
    /// and every
    /// notification rule in your Amazon Web Services account are deleted.
    force_unsubscribe_all: ?bool = null,

    /// The Amazon Resource Name (ARN) of the Amazon Q Developer in chat
    /// applications topic or Amazon Q Developer in chat applications client to
    /// delete.
    target_address: []const u8,

    pub const json_field_names = .{
        .force_unsubscribe_all = "ForceUnsubscribeAll",
        .target_address = "TargetAddress",
    };
};

pub const DeleteTargetOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteTargetInput, options: CallOptions) !DeleteTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codestar-notifications", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestar-notifications", "codestar notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/deleteTarget";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.force_unsubscribe_all) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ForceUnsubscribeAll\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetAddress\":");
    try aws.json.writeValue(@TypeOf(input.target_address), input.target_address, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteTargetOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteTargetOutput = .{};

    return result;
}
