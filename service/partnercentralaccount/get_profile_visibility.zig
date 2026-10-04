const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileVisibility = @import("profile_visibility.zig").ProfileVisibility;

pub const GetProfileVisibilityInput = struct {
    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// The unique identifier of the partner account.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetProfileVisibilityOutput = struct {
    /// The Amazon Resource Name (ARN) of the partner account.
    arn: []const u8,

    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// The unique identifier of the partner account.
    id: []const u8,

    /// The unique identifier of the partner profile.
    profile_id: []const u8,

    /// The visibility setting for the partner profile (public, private, restricted,
    /// etc.).
    visibility: ProfileVisibility,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .id = "Id",
        .profile_id = "ProfileId",
        .visibility = "Visibility",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProfileVisibilityInput, options: CallOptions) !GetProfileVisibilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProfileVisibilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.GetProfileVisibility");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProfileVisibilityOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetProfileVisibilityOutput, body, allocator);
}
