const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FulfillmentDetails = @import("fulfillment_details.zig").FulfillmentDetails;
const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const BenefitAllocationStatus = @import("benefit_allocation_status.zig").BenefitAllocationStatus;

pub const GetBenefitAllocationInput = struct {
    /// The catalog identifier that specifies which benefit catalog to query.
    catalog: []const u8,

    /// The unique identifier of the benefit allocation to retrieve.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetBenefitAllocationOutput = struct {
    /// A list of benefit identifiers that this allocation can be applied to.
    applicable_benefit_ids: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the benefit allocation.
    arn: ?[]const u8 = null,

    /// The identifier of the benefit application that resulted in this allocation.
    benefit_application_id: ?[]const u8 = null,

    /// The identifier of the benefit that this allocation is based on.
    benefit_id: ?[]const u8 = null,

    /// The catalog identifier that the benefit allocation belongs to.
    catalog: ?[]const u8 = null,

    /// The timestamp when the benefit allocation was created.
    created_at: ?i64 = null,

    /// A detailed description of the benefit allocation.
    description: ?[]const u8 = null,

    /// The timestamp when the benefit allocation expires and is no longer usable.
    expires_at: ?i64 = null,

    /// Detailed information about how the benefit allocation is fulfilled.
    fulfillment_detail: ?FulfillmentDetails = null,

    /// The fulfillment type used for this benefit allocation.
    fulfillment_type: ?FulfillmentType = null,

    /// The unique identifier of the benefit allocation.
    id: ?[]const u8 = null,

    /// The human-readable name of the benefit allocation.
    name: ?[]const u8 = null,

    /// The timestamp when the benefit allocation becomes active and usable.
    starts_at: ?i64 = null,

    /// The current status of the benefit allocation (e.g., active, expired,
    /// consumed).
    status: ?BenefitAllocationStatus = null,

    /// Additional information explaining the current status of the benefit
    /// allocation.
    status_reason: ?[]const u8 = null,

    /// The timestamp when the benefit allocation was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .applicable_benefit_ids = "ApplicableBenefitIds",
        .arn = "Arn",
        .benefit_application_id = "BenefitApplicationId",
        .benefit_id = "BenefitId",
        .catalog = "Catalog",
        .created_at = "CreatedAt",
        .description = "Description",
        .expires_at = "ExpiresAt",
        .fulfillment_detail = "FulfillmentDetail",
        .fulfillment_type = "FulfillmentType",
        .id = "Id",
        .name = "Name",
        .starts_at = "StartsAt",
        .status = "Status",
        .status_reason = "StatusReason",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBenefitAllocationInput, options: CallOptions) !GetBenefitAllocationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBenefitAllocationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.GetBenefitAllocation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBenefitAllocationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetBenefitAllocationOutput, body, allocator);
}
