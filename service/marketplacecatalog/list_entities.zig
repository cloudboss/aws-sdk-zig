const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EntityTypeFilters = @import("entity_type_filters.zig").EntityTypeFilters;
const EntityTypeSort = @import("entity_type_sort.zig").EntityTypeSort;
const Filter = @import("filter.zig").Filter;
const OwnershipType = @import("ownership_type.zig").OwnershipType;
const Sort = @import("sort.zig").Sort;
const EntitySummary = @import("entity_summary.zig").EntitySummary;

pub const ListEntitiesInput = struct {
    /// The catalog related to the request. Fixed value: `AWSMarketplace`
    catalog: []const u8,

    /// The type of entities to
    /// retrieve. Valid
    /// values are: `AmiProduct`, `ContainerProduct`,
    /// `DataProduct`, `SaaSProduct`, `ProcurementPolicy`,
    /// `Experience`, `Audience`, `BrandingSettings`,
    /// `Offer`, `OfferSet`, `Seller`,
    /// `ResaleAuthorization`, `Solution`.
    entity_type: []const u8,

    /// A Union object containing filter shapes for all `EntityType`s. Each
    /// `EntityTypeFilter` shape will have filters applicable for that
    /// `EntityType` that can be used to search or filter entities.
    entity_type_filters: ?EntityTypeFilters = null,

    /// A Union object containing `Sort` shapes for all `EntityType`s.
    /// Each `EntityTypeSort` shape will have `SortBy` and
    /// `SortOrder` applicable for fields on that `EntityType`. This
    /// can be used to sort the results of the filter query.
    entity_type_sort: ?EntityTypeSort = null,

    /// An array of filter objects. Each filter object contains two attributes,
    /// `filterName` and `filterValues`.
    filter_list: ?[]const Filter = null,

    /// Specifies the upper limit of the elements on a single page. If a value isn't
    /// provided,
    /// the default value is 20.
    max_results: ?i32 = null,

    /// The value of the next token, if it exists. Null if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    /// Filters the returned set of entities based on their owner. The default is
    /// `SELF`. To list entities shared with you
    /// through AWS Resource Access Manager (AWS RAM), set to `SHARED`. Entities
    /// shared through the AWS Marketplace
    /// Catalog API `PutResourcePolicy` operation can't be discovered through the
    /// `SHARED` parameter.
    ownership_type: ?OwnershipType = null,

    /// An object that contains two attributes, `SortBy` and
    /// `SortOrder`.
    sort: ?Sort = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .entity_type = "EntityType",
        .entity_type_filters = "EntityTypeFilters",
        .entity_type_sort = "EntityTypeSort",
        .filter_list = "FilterList",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .ownership_type = "OwnershipType",
        .sort = "Sort",
    };
};

pub const ListEntitiesOutput = struct {
    /// Array of `EntitySummary` objects.
    entity_summary_list: ?[]const EntitySummary = null,

    /// The value of the next token if it exists. Null if there is no more result.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity_summary_list = "EntitySummaryList",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEntitiesInput, options: Options) !ListEntitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "marketplacecatalog");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEntitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("marketplacecatalog", "Marketplace Catalog", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/ListEntities";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Catalog\":");
    try aws.json.writeValue(@TypeOf(input.catalog), input.catalog, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EntityType\":");
    try aws.json.writeValue(@TypeOf(input.entity_type), input.entity_type, allocator, &body_buf);
    has_prev = true;
    if (input.entity_type_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EntityTypeFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entity_type_sort) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EntityTypeSort\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ownership_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OwnershipType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Sort\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEntitiesOutput {
    var result: ListEntitiesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListEntitiesOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_supported_exception = .{
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
