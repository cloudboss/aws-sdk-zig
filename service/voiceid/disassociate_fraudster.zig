const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Fraudster = @import("fraudster.zig").Fraudster;

pub const DisassociateFraudsterInput = struct {
    /// The identifier of the domain that contains the fraudster.
    domain_id: []const u8,

    /// The identifier of the fraudster to be disassociated from the watchlist.
    fraudster_id: []const u8,

    /// The identifier of the watchlist that you want to disassociate from the
    /// fraudster.
    watchlist_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .fraudster_id = "FraudsterId",
        .watchlist_id = "WatchlistId",
    };
};

pub const DisassociateFraudsterOutput = struct {
    fraudster: ?Fraudster = null,

    pub const json_field_names = .{
        .fraudster = "Fraudster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateFraudsterInput, options: CallOptions) !DisassociateFraudsterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateFraudsterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "VoiceID.DisassociateFraudster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateFraudsterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateFraudsterOutput, body, allocator);
}
