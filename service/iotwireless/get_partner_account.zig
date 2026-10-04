const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartnerType = @import("partner_type.zig").PartnerType;
const SidewalkAccountInfoWithFingerprint = @import("sidewalk_account_info_with_fingerprint.zig").SidewalkAccountInfoWithFingerprint;

pub const GetPartnerAccountInput = struct {
    /// The partner account ID to disassociate from the AWS account.
    partner_account_id: []const u8,

    /// The partner type.
    partner_type: PartnerType,

    pub const json_field_names = .{
        .partner_account_id = "PartnerAccountId",
        .partner_type = "PartnerType",
    };
};

pub const GetPartnerAccountOutput = struct {
    /// Whether the partner account is linked to the AWS account.
    account_linked: ?bool = null,

    /// The Sidewalk account credentials.
    sidewalk: ?SidewalkAccountInfoWithFingerprint = null,

    pub const json_field_names = .{
        .account_linked = "AccountLinked",
        .sidewalk = "Sidewalk",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPartnerAccountInput, options: CallOptions) !GetPartnerAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPartnerAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/partner-accounts/");
    try path_buf.appendSlice(allocator, input.partner_account_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "partnerType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.partner_type.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPartnerAccountOutput {
    var result: GetPartnerAccountOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPartnerAccountOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
