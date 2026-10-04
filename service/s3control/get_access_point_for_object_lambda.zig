const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ObjectLambdaAccessPointAlias = @import("object_lambda_access_point_alias.zig").ObjectLambdaAccessPointAlias;
const PublicAccessBlockConfiguration = @import("public_access_block_configuration.zig").PublicAccessBlockConfiguration;
const serde = @import("serde.zig");

pub const GetAccessPointForObjectLambdaInput = struct {
    /// The account ID for the account that owns the specified Object Lambda Access
    /// Point.
    account_id: []const u8,

    /// The name of the Object Lambda Access Point.
    name: []const u8,
};

pub const GetAccessPointForObjectLambdaOutput = struct {
    /// The alias of the Object Lambda Access Point.
    alias: ?ObjectLambdaAccessPointAlias = null,

    /// The date and time when the specified Object Lambda Access Point was created.
    creation_date: ?i64 = null,

    /// The name of the Object Lambda Access Point.
    name: ?[]const u8 = null,

    /// Configuration to block all public access. This setting is turned on and can
    /// not be
    /// edited.
    public_access_block_configuration: ?PublicAccessBlockConfiguration = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccessPointForObjectLambdaInput, options: CallOptions) !GetAccessPointForObjectLambdaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccessPointForObjectLambdaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/accesspointforobjectlambda/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccessPointForObjectLambdaOutput {
    var result: GetAccessPointForObjectLambdaOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try serde.deserializeObjectLambdaAccessPointAlias(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "CreationDate")) {
                    result.creation_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicAccessBlockConfiguration")) {
                    result.public_access_block_configuration = try serde.deserializePublicAccessBlockConfiguration(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
