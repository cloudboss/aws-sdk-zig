const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EnumerationValue = @import("enumeration_value.zig").EnumerationValue;
const SlotTypeConfiguration = @import("slot_type_configuration.zig").SlotTypeConfiguration;
const SlotValueSelectionStrategy = @import("slot_value_selection_strategy.zig").SlotValueSelectionStrategy;

pub const GetSlotTypeInput = struct {
    /// The name of the slot type. The name is case sensitive.
    name: []const u8,

    /// The version of the slot type.
    version: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .version = "version",
    };
};

pub const GetSlotTypeOutput = struct {
    /// Checksum of the `$LATEST` version of the slot
    /// type.
    checksum: ?[]const u8 = null,

    /// The date that the slot type was created.
    created_date: ?i64 = null,

    /// A description of the slot type.
    description: ?[]const u8 = null,

    /// A list of `EnumerationValue` objects that defines the
    /// values that the slot type can take.
    enumeration_values: ?[]const EnumerationValue = null,

    /// The date that the slot type was updated. When you create a
    /// resource, the creation date and last update date are the same.
    last_updated_date: ?i64 = null,

    /// The name of the slot type.
    name: ?[]const u8 = null,

    /// The built-in slot type used as a parent for the slot type.
    parent_slot_type_signature: ?[]const u8 = null,

    /// Configuration information that extends the parent built-in slot
    /// type.
    slot_type_configurations: ?[]const SlotTypeConfiguration = null,

    /// The strategy that Amazon Lex uses to determine the value of the slot.
    /// For more information, see PutSlotType.
    value_selection_strategy: ?SlotValueSelectionStrategy = null,

    /// The version of the slot type.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .checksum = "checksum",
        .created_date = "createdDate",
        .description = "description",
        .enumeration_values = "enumerationValues",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .parent_slot_type_signature = "parentSlotTypeSignature",
        .slot_type_configurations = "slotTypeConfigurations",
        .value_selection_strategy = "valueSelectionStrategy",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSlotTypeInput, options: CallOptions) !GetSlotTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelbuildingservice");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSlotTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelbuildingservice", "Lex Model Building Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/slottypes/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSlotTypeOutput {
    var result: GetSlotTypeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSlotTypeOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
