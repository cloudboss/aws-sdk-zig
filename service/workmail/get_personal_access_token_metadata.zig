const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetPersonalAccessTokenMetadataInput = struct {
    /// The Organization ID.
    organization_id: []const u8,

    /// The Personal Access Token ID.
    personal_access_token_id: []const u8,

    pub const json_field_names = .{
        .organization_id = "OrganizationId",
        .personal_access_token_id = "PersonalAccessTokenId",
    };
};

pub const GetPersonalAccessTokenMetadataOutput = struct {
    /// The date when the Personal Access Token ID was created.
    date_created: ?i64 = null,

    /// The date when the Personal Access Token ID was last used.
    date_last_used: ?i64 = null,

    /// The time when the Personal Access Token ID will expire.
    expires_time: ?i64 = null,

    /// The Personal Access Token name.
    name: ?[]const u8 = null,

    /// The Personal Access Token ID.
    personal_access_token_id: ?[]const u8 = null,

    /// Lists all the Personal Access Token permissions for a mailbox.
    scopes: ?[]const []const u8 = null,

    /// The WorkMail User ID.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .date_created = "DateCreated",
        .date_last_used = "DateLastUsed",
        .expires_time = "ExpiresTime",
        .name = "Name",
        .personal_access_token_id = "PersonalAccessTokenId",
        .scopes = "Scopes",
        .user_id = "UserId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPersonalAccessTokenMetadataInput, options: CallOptions) !GetPersonalAccessTokenMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPersonalAccessTokenMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.GetPersonalAccessTokenMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPersonalAccessTokenMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPersonalAccessTokenMetadataOutput, body, allocator);
}
