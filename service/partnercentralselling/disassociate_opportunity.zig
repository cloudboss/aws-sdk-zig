const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RelatedEntityType = @import("related_entity_type.zig").RelatedEntityType;

pub const DisassociateOpportunityInput = struct {
    /// Specifies the catalog associated with the request. This field takes a string
    /// value from a predefined list: `AWS` or `Sandbox`. The catalog determines
    /// which environment the opportunity disassociation is made in. Use `AWS` to
    /// disassociate opportunities in the Amazon Web Services catalog, and `Sandbox`
    /// for testing in secure, isolated environments.
    catalog: []const u8,

    /// The opportunity's unique identifier for when you want to disassociate it
    /// from related entities. This identifier helps to ensure that the correct
    /// opportunity is updated.
    ///
    /// Validation: Ensure that the provided identifier corresponds to an existing
    /// opportunity in the Amazon Web Services system because incorrect identifiers
    /// result in an error and no changes are made.
    opportunity_identifier: []const u8,

    /// The related entity's identifier that you want to disassociate from the
    /// opportunity. Depending on the type of entity, this could be a simple
    /// identifier or an Amazon Resource Name (ARN) for entities managed through
    /// Amazon Web Services Marketplace.
    ///
    /// For Amazon Web Services Marketplace entities, use the Amazon Web Services
    /// Marketplace API to obtain the necessary ARNs. For guidance on retrieving
    /// these ARNs, see [ Amazon Web Services MarketplaceUsing the Amazon Web
    /// Services Marketplace Catalog
    /// API](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/welcome.html).
    ///
    /// Validation: Ensure the identifier or ARN is valid and corresponds to an
    /// existing entity. An incorrect or invalid identifier results in an error.
    related_entity_identifier: []const u8,

    /// The type of the entity that you're disassociating from the opportunity. When
    /// you specify the entity type, it helps the system correctly process the
    /// disassociation request to ensure that the right connections are removed.
    ///
    /// Examples of entity types include Partner Solution, Amazon Web Services
    /// product, and Amazon Web Services Marketplaceoffer. Ensure that the value
    /// matches one of the expected entity types.
    ///
    /// Validation: Provide a valid entity type to help ensure successful
    /// disassociation. An invalid or incorrect entity type results in an error.
    related_entity_type: RelatedEntityType,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .opportunity_identifier = "OpportunityIdentifier",
        .related_entity_identifier = "RelatedEntityIdentifier",
        .related_entity_type = "RelatedEntityType",
    };
};

pub const DisassociateOpportunityOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateOpportunityInput, options: CallOptions) !DisassociateOpportunityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateOpportunityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.DisassociateOpportunity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateOpportunityOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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
