const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Watchlist = @import("watchlist.zig").Watchlist;

pub const UpdateWatchlistInput = struct {
    /// A brief description about this watchlist.
    description: ?[]const u8 = null,

    /// The identifier of the domain that contains the watchlist.
    domain_id: []const u8,

    /// The name of the watchlist.
    name: ?[]const u8 = null,

    /// The identifier of the watchlist to be updated.
    watchlist_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .domain_id = "DomainId",
        .name = "Name",
        .watchlist_id = "WatchlistId",
    };
};

pub const UpdateWatchlistOutput = struct {
    /// Details about the updated watchlist.
    watchlist: ?Watchlist = null,

    pub const json_field_names = .{
        .watchlist = "Watchlist",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWatchlistInput, options: CallOptions) !UpdateWatchlistOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "voiceid", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWatchlistInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voiceid", "Voice ID", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VoiceID.UpdateWatchlist");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWatchlistOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateWatchlistOutput, body, allocator);
}
