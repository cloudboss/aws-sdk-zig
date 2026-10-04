const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileInput = @import("file_input.zig").FileInput;
const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const Contact = @import("contact.zig").Contact;
const Tag = @import("tag.zig").Tag;

pub const CreateBenefitApplicationInput = struct {
    /// AWS resources that are associated with this benefit application.
    associated_resources: ?[]const []const u8 = null,

    /// Detailed information and requirements specific to the benefit being
    /// requested.
    benefit_application_details: ?[]const u8 = null,

    /// The unique identifier of the benefit being requested in this application.
    benefit_identifier: []const u8,

    /// The catalog identifier that specifies which benefit catalog to create the
    /// application in.
    catalog: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotent processing of the
    /// creation request.
    client_token: []const u8,

    /// A detailed description of the benefit application and its intended use.
    description: ?[]const u8 = null,

    /// Supporting documents and files attached to the benefit application.
    file_details: ?[]const FileInput = null,

    /// The types of fulfillment requested for this benefit application (e.g.,
    /// credits, access, disbursement).
    fulfillment_types: ?[]const FulfillmentType = null,

    /// A human-readable name for the benefit application.
    name: ?[]const u8 = null,

    /// Contact information for partner representatives responsible for this benefit
    /// application.
    partner_contacts: ?[]const Contact = null,

    /// Key-value pairs to categorize and organize the benefit application.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .associated_resources = "AssociatedResources",
        .benefit_application_details = "BenefitApplicationDetails",
        .benefit_identifier = "BenefitIdentifier",
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .description = "Description",
        .file_details = "FileDetails",
        .fulfillment_types = "FulfillmentTypes",
        .name = "Name",
        .partner_contacts = "PartnerContacts",
        .tags = "Tags",
    };
};

pub const CreateBenefitApplicationOutput = struct {
    /// The Amazon Resource Name (ARN) of the newly created benefit application.
    arn: ?[]const u8 = null,

    /// The unique identifier assigned to the newly created benefit application.
    id: ?[]const u8 = null,

    /// The initial revision number of the newly created benefit application.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .revision = "Revision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBenefitApplicationInput, options: CallOptions) !CreateBenefitApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBenefitApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-benefits", "PartnerCentral Benefits", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.CreateBenefitApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBenefitApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateBenefitApplicationOutput, body, allocator);
}
