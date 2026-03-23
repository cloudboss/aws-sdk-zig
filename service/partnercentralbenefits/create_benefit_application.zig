const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBenefitApplicationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.CreateBenefitApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBenefitApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateBenefitApplicationOutput, body, allocator);
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
