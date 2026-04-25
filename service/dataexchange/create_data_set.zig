const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AssetType = @import("asset_type.zig").AssetType;
const Origin = @import("origin.zig").Origin;
const OriginDetails = @import("origin_details.zig").OriginDetails;

pub const CreateDataSetInput = struct {
    /// The type of asset that is added to a data set.
    asset_type: AssetType,

    /// A description for the data set. This value can be up to 16,348 characters
    /// long.
    description: []const u8,

    /// The name of the data set.
    name: []const u8,

    /// A data set tag is an optional label that you can assign to a data set when
    /// you create it. Each tag consists of a key and an optional value, both of
    /// which you define. When you use tagging, you can also use tag-based access
    /// control in IAM policies to control access to these data sets and revisions.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .asset_type = "AssetType",
        .description = "Description",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateDataSetOutput = struct {
    /// The ARN for the data set.
    arn: ?[]const u8 = null,

    /// The type of asset that is added to a data set.
    asset_type: ?AssetType = null,

    /// The date and time that the data set was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// The description for the data set.
    description: ?[]const u8 = null,

    /// The unique identifier for the data set.
    id: ?[]const u8 = null,

    /// The name of the data set.
    name: ?[]const u8 = null,

    /// A property that defines the data set as OWNED by the account (for providers)
    /// or ENTITLED to the account (for subscribers).
    origin: ?Origin = null,

    /// If the origin of this data set is ENTITLED, includes the details for the
    /// product on AWS Marketplace.
    origin_details: ?OriginDetails = null,

    /// The data set ID of the owned data set corresponding to the entitled data set
    /// being viewed. This parameter is returned when a data set owner is viewing
    /// the entitled copy of its owned data set.
    source_id: ?[]const u8 = null,

    /// The tags for the data set.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The date and time that the data set was last updated, in ISO 8601 format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_type = "AssetType",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .origin = "Origin",
        .origin_details = "OriginDetails",
        .source_id = "SourceId",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataSetInput, options: CallOptions) !CreateDataSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dataexchange");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/data-sets";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AssetType\":");
    try aws.json.writeValue(@TypeOf(input.asset_type), input.asset_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataSetOutput {
    var result: CreateDataSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataSetOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ServiceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_limit_exceeded_exception = .{
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
