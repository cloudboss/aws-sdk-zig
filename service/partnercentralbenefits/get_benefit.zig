const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const BenefitStatus = @import("benefit_status.zig").BenefitStatus;

pub const GetBenefitInput = struct {
    /// The catalog identifier that specifies which benefit catalog to query.
    catalog: []const u8,

    /// The unique identifier of the benefit to retrieve.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetBenefitOutput = struct {
    /// The Amazon Resource Name (ARN) of the benefit.
    arn: ?[]const u8 = null,

    /// The schema definition that describes the required fields for requesting this
    /// benefit.
    benefit_request_schema: ?[]const u8 = null,

    /// The catalog identifier that the benefit belongs to.
    catalog: ?[]const u8 = null,

    /// A detailed description of the benefit and its purpose.
    description: ?[]const u8 = null,

    /// The available fulfillment types for this benefit (e.g., credits, access,
    /// disbursement).
    fulfillment_types: ?[]const FulfillmentType = null,

    /// The unique identifier of the benefit.
    id: ?[]const u8 = null,

    /// The human-readable name of the benefit.
    name: ?[]const u8 = null,

    /// The AWS partner programs that this benefit is associated with.
    programs: ?[]const []const u8 = null,

    /// The current status of the benefit (e.g., active, inactive, deprecated).
    status: ?BenefitStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .benefit_request_schema = "BenefitRequestSchema",
        .catalog = "Catalog",
        .description = "Description",
        .fulfillment_types = "FulfillmentTypes",
        .id = "Id",
        .name = "Name",
        .programs = "Programs",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBenefitInput, options: CallOptions) !GetBenefitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBenefitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.GetBenefit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBenefitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetBenefitOutput, body, allocator);
}
