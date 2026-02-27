const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBenefitAllocationInput, options: Options) !GetBenefitAllocationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentralbenefits");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetBenefitAllocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentralbenefits", "PartnerCentral Benefits", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "PartnerCentralBenefitsService.GetBenefitAllocation");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetBenefitAllocationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetBenefitAllocationOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
