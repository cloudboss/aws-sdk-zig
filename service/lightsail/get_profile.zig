const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartnerInfo = @import("partner_info.zig").PartnerInfo;
const ProfileType = @import("profile_type.zig").ProfileType;

pub const GetProfileInput = struct {
};

pub const GetProfileOutput = struct {
    /// An object that describes the partner membership of the account, such as the
    /// tier of the
    /// membership, its status, and when the account was enrolled.
    ///
    /// This parameter is returned only for accounts that have a `profileType` of
    /// `LightsailPartner`.
    partner: ?PartnerInfo = null,

    /// The type of the profile.
    ///
    /// The following profile types are possible:
    ///
    /// * `Lightsailor` – The account is not enrolled in the Lightsail partner
    /// program.
    ///
    /// * `LightsailPartner` – The account is enrolled in the Lightsail partner
    /// program.
    profile_type: ProfileType,

    pub const json_field_names = .{
        .partner = "partner",
        .profile_type = "profileType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProfileInput, options: CallOptions) !GetProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProfileInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProfileOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetProfileOutput, body, allocator);
}
