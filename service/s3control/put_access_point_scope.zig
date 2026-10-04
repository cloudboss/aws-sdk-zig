const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;
const serde = @import("serde.zig");

pub const PutAccessPointScopeInput = struct {
    /// The Amazon Web Services account ID that owns the access point with scope
    /// that you want to create or replace.
    account_id: []const u8,

    /// The name of the access point with the scope that you want to create or
    /// replace.
    name: []const u8,

    /// Object prefixes, API operations, or a combination of both.
    scope: Scope,
};

pub const PutAccessPointScopeOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccessPointScopeInput, options: CallOptions) !PutAccessPointScopeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAccessPointScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/accesspoint/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/scope");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<PutAccessPointScopeRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    try body_buf.appendSlice(allocator, "<Scope>");
    try serde.serializeScope(allocator, &body_buf, input.scope);
    try body_buf.appendSlice(allocator, "</Scope>");
    try body_buf.appendSlice(allocator, "</PutAccessPointScopeRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAccessPointScopeOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutAccessPointScopeOutput = .{};

    return result;
}
