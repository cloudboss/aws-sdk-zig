const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RemoveStreamGroupLocationsInput = struct {
    /// A stream group to remove the specified locations from.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    identifier: []const u8,

    /// A set of locations to remove this stream group. For example, `us-east-1`.
    ///
    /// For a complete list of locations that Amazon GameLift Streams supports,
    /// refer to [Regions, quotas, and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    locations: []const []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .locations = "Locations",
    };
};

pub const RemoveStreamGroupLocationsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveStreamGroupLocationsInput, options: CallOptions) !RemoveStreamGroupLocationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gameliftstreams", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveStreamGroupLocationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/locations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    for (input.locations) |item| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "locations=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, item);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveStreamGroupLocationsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RemoveStreamGroupLocationsOutput = .{};

    return result;
}
