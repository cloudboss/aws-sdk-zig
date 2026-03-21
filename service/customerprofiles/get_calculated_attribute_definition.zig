const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeDetails = @import("attribute_details.zig").AttributeDetails;
const Conditions = @import("conditions.zig").Conditions;
const Filter = @import("filter.zig").Filter;
const Readiness = @import("readiness.zig").Readiness;
const Statistic = @import("statistic.zig").Statistic;
const ReadinessStatus = @import("readiness_status.zig").ReadinessStatus;

pub const GetCalculatedAttributeDefinitionInput = struct {
    /// The unique name of the calculated attribute.
    calculated_attribute_name: []const u8,

    /// The unique name of the domain.
    domain_name: []const u8,

    pub const json_field_names = .{
        .calculated_attribute_name = "CalculatedAttributeName",
        .domain_name = "DomainName",
    };
};

pub const GetCalculatedAttributeDefinitionOutput = struct {
    /// Mathematical expression and a list of attribute items specified in that
    /// expression.
    attribute_details: ?AttributeDetails = null,

    /// The unique name of the calculated attribute.
    calculated_attribute_name: ?[]const u8 = null,

    /// The conditions including range, object count, and threshold for the
    /// calculated
    /// attribute.
    conditions: ?Conditions = null,

    /// The timestamp of when the calculated attribute definition was created.
    created_at: ?i64 = null,

    /// The description of the calculated attribute.
    description: ?[]const u8 = null,

    /// The display name of the calculated attribute.
    display_name: ?[]const u8 = null,

    /// The filter assigned to this calculated attribute definition.
    filter: ?Filter = null,

    /// The timestamp of when the calculated attribute definition was most recently
    /// edited.
    last_updated_at: ?i64 = null,

    /// Information indicating if the Calculated Attribute is ready for use by
    /// confirming all
    /// historical data has been processed and reflected.
    readiness: ?Readiness = null,

    /// The aggregation operation to perform for the calculated attribute.
    statistic: ?Statistic = null,

    /// Status of the Calculated Attribute creation (whether all historical data has
    /// been
    /// indexed).
    status: ?ReadinessStatus = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Whether historical data ingested before the Calculated Attribute was created
    /// should be
    /// included in calculations.
    use_historical_data: ?bool = null,

    pub const json_field_names = .{
        .attribute_details = "AttributeDetails",
        .calculated_attribute_name = "CalculatedAttributeName",
        .conditions = "Conditions",
        .created_at = "CreatedAt",
        .description = "Description",
        .display_name = "DisplayName",
        .filter = "Filter",
        .last_updated_at = "LastUpdatedAt",
        .readiness = "Readiness",
        .statistic = "Statistic",
        .status = "Status",
        .tags = "Tags",
        .use_historical_data = "UseHistoricalData",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCalculatedAttributeDefinitionInput, options: CallOptions) !GetCalculatedAttributeDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "profile");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCalculatedAttributeDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/calculated-attributes/");
    try path_buf.appendSlice(allocator, input.calculated_attribute_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCalculatedAttributeDefinitionOutput {
    var result: GetCalculatedAttributeDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCalculatedAttributeDefinitionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
