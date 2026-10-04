const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileDetail = @import("file_detail.zig").FileDetail;
const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const Contact = @import("contact.zig").Contact;
const BenefitApplicationStatus = @import("benefit_application_status.zig").BenefitApplicationStatus;

pub const GetBenefitApplicationInput = struct {
    /// The catalog identifier that specifies which benefit catalog to query.
    catalog: []const u8,

    /// The unique identifier of the benefit application to retrieve.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetBenefitApplicationOutput = struct {
    /// The Amazon Resource Name (ARN) of the benefit application.
    arn: ?[]const u8 = null,

    /// AWS resources that are associated with this benefit application.
    associated_resources: ?[]const []const u8 = null,

    /// Detailed information and requirements specific to the benefit being
    /// requested.
    benefit_application_details: ?[]const u8 = null,

    /// The identifier of the benefit being requested in this application.
    benefit_id: ?[]const u8 = null,

    /// The catalog identifier that the benefit application belongs to.
    catalog: ?[]const u8 = null,

    /// The timestamp when the benefit application was created.
    created_at: ?i64 = null,

    /// A detailed description of the benefit application.
    description: ?[]const u8 = null,

    /// Supporting documents and files attached to the benefit application.
    file_details: ?[]const FileDetail = null,

    /// The fulfillment types requested for this benefit application.
    fulfillment_types: ?[]const FulfillmentType = null,

    /// The unique identifier of the benefit application.
    id: ?[]const u8 = null,

    /// The human-readable name of the benefit application.
    name: ?[]const u8 = null,

    /// Contact information for partner representatives responsible for this benefit
    /// application.
    partner_contacts: ?[]const Contact = null,

    /// The AWS partner programs associated with this benefit application.
    programs: ?[]const []const u8 = null,

    /// The current revision number of the benefit application.
    revision: ?[]const u8 = null,

    /// The current stage in the benefit application processing workflow.
    stage: ?[]const u8 = null,

    /// The current processing status of the benefit application.
    status: ?BenefitApplicationStatus = null,

    /// Additional information explaining the current status of the benefit
    /// application.
    status_reason: ?[]const u8 = null,

    /// A standardized code representing the reason for the current status.
    status_reason_code: ?[]const u8 = null,

    /// The list of standardized codes representing the reason for the current
    /// status.
    status_reason_codes: ?[]const []const u8 = null,

    /// The timestamp when the benefit application was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_resources = "AssociatedResources",
        .benefit_application_details = "BenefitApplicationDetails",
        .benefit_id = "BenefitId",
        .catalog = "Catalog",
        .created_at = "CreatedAt",
        .description = "Description",
        .file_details = "FileDetails",
        .fulfillment_types = "FulfillmentTypes",
        .id = "Id",
        .name = "Name",
        .partner_contacts = "PartnerContacts",
        .programs = "Programs",
        .revision = "Revision",
        .stage = "Stage",
        .status = "Status",
        .status_reason = "StatusReason",
        .status_reason_code = "StatusReasonCode",
        .status_reason_codes = "StatusReasonCodes",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBenefitApplicationInput, options: CallOptions) !GetBenefitApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBenefitApplicationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.GetBenefitApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBenefitApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetBenefitApplicationOutput, body, allocator);
}
