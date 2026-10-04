const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileInput = @import("file_input.zig").FileInput;
const Contact = @import("contact.zig").Contact;

pub const UpdateBenefitApplicationInput = struct {
    /// Updated detailed information and requirements specific to the benefit being
    /// requested.
    benefit_application_details: ?[]const u8 = null,

    /// The catalog identifier that specifies which benefit catalog the application
    /// belongs to.
    catalog: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotent processing of the
    /// update request.
    client_token: []const u8,

    /// The updated detailed description of the benefit application.
    description: ?[]const u8 = null,

    /// Updated supporting documents and files attached to the benefit application.
    file_details: ?[]const FileInput = null,

    /// The unique identifier of the benefit application to update.
    identifier: []const u8,

    /// The updated human-readable name for the benefit application.
    name: ?[]const u8 = null,

    /// Updated contact information for partner representatives responsible for this
    /// benefit application.
    partner_contacts: ?[]const Contact = null,

    /// The current revision number of the benefit application to ensure optimistic
    /// concurrency control.
    revision: []const u8,

    pub const json_field_names = .{
        .benefit_application_details = "BenefitApplicationDetails",
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .description = "Description",
        .file_details = "FileDetails",
        .identifier = "Identifier",
        .name = "Name",
        .partner_contacts = "PartnerContacts",
        .revision = "Revision",
    };
};

pub const UpdateBenefitApplicationOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated benefit application.
    arn: ?[]const u8 = null,

    /// The unique identifier of the updated benefit application.
    id: ?[]const u8 = null,

    /// The new revision number of the benefit application after the update.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .revision = "Revision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBenefitApplicationInput, options: CallOptions) !UpdateBenefitApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBenefitApplicationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.UpdateBenefitApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBenefitApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateBenefitApplicationOutput, body, allocator);
}
