const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AssociatedResource = @import("associated_resource.zig").AssociatedResource;
const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const BenefitApplicationStatus = @import("benefit_application_status.zig").BenefitApplicationStatus;
const BenefitApplicationSummary = @import("benefit_application_summary.zig").BenefitApplicationSummary;

pub const ListBenefitApplicationsInput = struct {
    /// Filter benefit applications by specific AWS resource ARNs.
    associated_resource_arns: ?[]const []const u8 = null,

    /// Filter benefit applications by associated AWS resources.
    associated_resources: ?[]const AssociatedResource = null,

    /// Filter benefit applications by specific benefit identifiers.
    benefit_identifiers: ?[]const []const u8 = null,

    /// The catalog identifier to filter benefit applications by catalog.
    catalog: []const u8,

    /// Filter benefit applications by specific fulfillment types.
    fulfillment_types: ?[]const FulfillmentType = null,

    /// The maximum number of benefit applications to return in a single response.
    max_results: ?i32 = null,

    /// A pagination token to retrieve the next set of results from a previous
    /// request.
    next_token: ?[]const u8 = null,

    /// Filter benefit applications by specific AWS partner programs.
    programs: ?[]const []const u8 = null,

    /// Filter benefit applications by their current processing stage.
    stages: ?[]const []const u8 = null,

    /// Filter benefit applications by their current processing status.
    status: ?[]const BenefitApplicationStatus = null,

    pub const json_field_names = .{
        .associated_resource_arns = "AssociatedResourceArns",
        .associated_resources = "AssociatedResources",
        .benefit_identifiers = "BenefitIdentifiers",
        .catalog = "Catalog",
        .fulfillment_types = "FulfillmentTypes",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .programs = "Programs",
        .stages = "Stages",
        .status = "Status",
    };
};

pub const ListBenefitApplicationsOutput = struct {
    /// A list of benefit application summaries matching the specified criteria.
    benefit_application_summaries: ?[]const BenefitApplicationSummary = null,

    /// A pagination token to retrieve the next set of results, if more results are
    /// available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .benefit_application_summaries = "BenefitApplicationSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBenefitApplicationsInput, options: CallOptions) !ListBenefitApplicationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentral");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListBenefitApplicationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-benefits", "PartnerCentral Benefits", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.ListBenefitApplications");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBenefitApplicationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListBenefitApplicationsOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
