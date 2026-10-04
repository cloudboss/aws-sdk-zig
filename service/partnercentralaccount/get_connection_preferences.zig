const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessType = @import("access_type.zig").AccessType;

pub const GetConnectionPreferencesInput = struct {
    /// The catalog identifier for the partner account.
    catalog: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
    };
};

pub const GetConnectionPreferencesOutput = struct {
    /// The access type setting for connections (e.g., open, restricted,
    /// invitation-only).
    access_type: AccessType,

    /// The Amazon Resource Name (ARN) of the connection preferences.
    arn: []const u8,

    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// A list of participant IDs that are excluded from connection requests or
    /// interactions.
    excluded_participant_ids: ?[]const []const u8 = null,

    /// The revision number of the connection preferences for optimistic locking.
    revision: i64,

    /// The timestamp when the connection preferences were last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .access_type = "AccessType",
        .arn = "Arn",
        .catalog = "Catalog",
        .excluded_participant_ids = "ExcludedParticipantIds",
        .revision = "Revision",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConnectionPreferencesInput, options: CallOptions) !GetConnectionPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConnectionPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-account", "PartnerCentral Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.GetConnectionPreferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConnectionPreferencesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetConnectionPreferencesOutput, body, allocator);
}
