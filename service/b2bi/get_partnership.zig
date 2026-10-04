const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapabilityOptions = @import("capability_options.zig").CapabilityOptions;

pub const GetPartnershipInput = struct {
    /// Specifies the unique, system-generated identifier for a partnership.
    partnership_id: []const u8,

    pub const json_field_names = .{
        .partnership_id = "partnershipId",
    };
};

pub const GetPartnershipOutput = struct {
    /// Returns one or more capabilities associated with this partnership.
    capabilities: ?[]const []const u8 = null,

    capability_options: ?CapabilityOptions = null,

    /// Returns a timestamp for creation date and time of the partnership.
    created_at: i64,

    /// Returns the email address associated with this trading partner.
    email: ?[]const u8 = null,

    /// Returns a timestamp that identifies the most recent date and time that the
    /// partnership was modified.
    modified_at: ?i64 = null,

    /// Returns the display name of the partnership
    name: ?[]const u8 = null,

    /// Returns an Amazon Resource Name (ARN) for a specific Amazon Web Services
    /// resource, such as a capability, partnership, profile, or transformer.
    partnership_arn: []const u8,

    /// Returns the unique, system-generated identifier for a partnership.
    partnership_id: []const u8,

    /// Returns the phone number associated with the partnership.
    phone: ?[]const u8 = null,

    /// Returns the unique, system-generated identifier for the profile connected to
    /// this partnership.
    profile_id: []const u8,

    /// Returns the unique identifier for the partner for this partnership.
    trading_partner_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .capability_options = "capabilityOptions",
        .created_at = "createdAt",
        .email = "email",
        .modified_at = "modifiedAt",
        .name = "name",
        .partnership_arn = "partnershipArn",
        .partnership_id = "partnershipId",
        .phone = "phone",
        .profile_id = "profileId",
        .trading_partner_id = "tradingPartnerId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPartnershipInput, options: CallOptions) !GetPartnershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "b2bi", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPartnershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("b2bi", "b2bi", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.GetPartnership");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPartnershipOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetPartnershipOutput, body, allocator);
}
