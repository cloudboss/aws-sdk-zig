const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AllianceLeadContact = @import("alliance_lead_contact.zig").AllianceLeadContact;
const PrimarySolutionType = @import("primary_solution_type.zig").PrimarySolutionType;
const Tag = @import("tag.zig").Tag;
const PartnerDomain = @import("partner_domain.zig").PartnerDomain;
const PartnerProfile = @import("partner_profile.zig").PartnerProfile;

pub const CreatePartnerInput = struct {
    /// The primary contact person for alliance and partnership matters.
    alliance_lead_contact: AllianceLeadContact,

    /// The catalog identifier where the partner account will be created.
    catalog: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The verification code sent to the alliance lead contact's email to confirm
    /// account creation.
    email_verification_code: []const u8,

    /// The legal name of the organization becoming a partner.
    legal_name: []const u8,

    /// The primary type of solution or service the partner provides (e.g.,
    /// consulting, software, managed services).
    primary_solution_type: PrimarySolutionType,

    /// A list of tags to associate with the partner account for organization and
    /// billing purposes.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .alliance_lead_contact = "AllianceLeadContact",
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .email_verification_code = "EmailVerificationCode",
        .legal_name = "LegalName",
        .primary_solution_type = "PrimarySolutionType",
        .tags = "Tags",
    };
};

pub const CreatePartnerOutput = struct {
    /// The alliance lead contact information for the partner account.
    alliance_lead_contact: ?AllianceLeadContact = null,

    /// The Amazon Resource Name (ARN) of the created partner account.
    arn: []const u8,

    /// The list of verified email domains associated with AWS training and
    /// certification credentials for the partner organization.
    aws_training_certification_email_domains: ?[]const PartnerDomain = null,

    /// The catalog identifier where the partner account was created.
    catalog: []const u8,

    /// The timestamp when the partner account was created.
    created_at: i64,

    /// The unique identifier of the created partner account.
    id: []const u8,

    /// The legal name of the partner organization.
    legal_name: []const u8,

    /// The partner profile information including display name, description, and
    /// other public details.
    profile: ?PartnerProfile = null,

    pub const json_field_names = .{
        .alliance_lead_contact = "AllianceLeadContact",
        .arn = "Arn",
        .aws_training_certification_email_domains = "AwsTrainingCertificationEmailDomains",
        .catalog = "Catalog",
        .created_at = "CreatedAt",
        .id = "Id",
        .legal_name = "LegalName",
        .profile = "Profile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePartnerInput, options: CallOptions) !CreatePartnerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePartnerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.CreatePartner");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePartnerOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreatePartnerOutput, body, allocator);
}
