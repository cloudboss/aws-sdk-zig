const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartnerDomain = @import("partner_domain.zig").PartnerDomain;
const PartnerProfile = @import("partner_profile.zig").PartnerProfile;

pub const GetPartnerInput = struct {
    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// The unique identifier of the partner account to retrieve.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetPartnerOutput = struct {
    /// The Amazon Resource Name (ARN) of the partner account.
    arn: []const u8,

    /// The list of verified email domains associated with AWS training and
    /// certification credentials for the partner organization.
    aws_training_certification_email_domains: ?[]const PartnerDomain = null,

    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// The timestamp when the partner account was created.
    created_at: i64,

    /// The unique identifier of the partner account.
    id: []const u8,

    /// The legal name of the partner organization.
    legal_name: []const u8,

    /// The partner profile information including display name, description, and
    /// other public details.
    profile: ?PartnerProfile = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .aws_training_certification_email_domains = "AwsTrainingCertificationEmailDomains",
        .catalog = "Catalog",
        .created_at = "CreatedAt",
        .id = "Id",
        .legal_name = "LegalName",
        .profile = "Profile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPartnerInput, options: CallOptions) !GetPartnerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPartnerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.GetPartner");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPartnerOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetPartnerOutput, body, allocator);
}
