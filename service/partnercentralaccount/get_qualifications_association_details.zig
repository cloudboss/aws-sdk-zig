const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QualificationsAssociationPartner = @import("qualifications_association_partner.zig").QualificationsAssociationPartner;
const QualificationsAssociationStatus = @import("qualifications_association_status.zig").QualificationsAssociationStatus;

pub const GetQualificationsAssociationDetailsInput = struct {
    /// The catalog in which to look up the qualifications association. Valid
    /// values: `AWS`, `Sandbox`.
    catalog: []const u8,

    /// Your partner identifier. You can provide either a partner ID (for example,
    /// `partner-abc123`) or a partner ARN. You must own this identifier.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetQualificationsAssociationDetailsOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies your partner
    /// resource.
    arn: []const u8,

    /// The list of all partner profile and account identifiers currently associated
    /// under the primary partner. This field is null when the status is
    /// `NOT_ASSOCIATED`.
    associated_partners: ?[]const QualificationsAssociationPartner = null,

    /// The catalog identifier echoed from the request.
    catalog: []const u8,

    /// Your unique partner identifier in the AWS Partner Network.
    id: []const u8,

    /// The primary partner's profile and account identifiers. This field is null
    /// when the status is `NOT_ASSOCIATED`.
    primary_partner: ?QualificationsAssociationPartner = null,

    /// The current qualifications association status. Valid values: `ASSOCIATED`
    /// (the partner is associated with a primary), `NOT_ASSOCIATED` (the partner
    /// has no active association).
    status: QualificationsAssociationStatus,

    /// The timestamp when the qualifications association was last updated, in ISO
    /// 8601 format. This field is null when the status is `NOT_ASSOCIATED`.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_partners = "AssociatedPartners",
        .catalog = "Catalog",
        .id = "Id",
        .primary_partner = "PrimaryPartner",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQualificationsAssociationDetailsInput, options: CallOptions) !GetQualificationsAssociationDetailsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQualificationsAssociationDetailsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.GetQualificationsAssociationDetails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQualificationsAssociationDetailsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetQualificationsAssociationDetailsOutput, body, allocator);
}
