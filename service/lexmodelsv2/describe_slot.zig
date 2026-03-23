const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MultipleValuesSetting = @import("multiple_values_setting.zig").MultipleValuesSetting;
const ObfuscationSetting = @import("obfuscation_setting.zig").ObfuscationSetting;
const SubSlotSetting = @import("sub_slot_setting.zig").SubSlotSetting;
const SlotValueElicitationSetting = @import("slot_value_elicitation_setting.zig").SlotValueElicitationSetting;

pub const DescribeSlotInput = struct {
    /// The identifier of the bot associated with the slot.
    bot_id: []const u8,

    /// The version of the bot associated with the slot.
    bot_version: []const u8,

    /// The identifier of the intent that contains the slot.
    intent_id: []const u8,

    /// The identifier of the language and locale of the slot to describe.
    /// The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// The unique identifier for the slot.
    slot_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .intent_id = "intentId",
        .locale_id = "localeId",
        .slot_id = "slotId",
    };
};

pub const DescribeSlotOutput = struct {
    /// The identifier of the bot associated with the slot.
    bot_id: ?[]const u8 = null,

    /// The version of the bot associated with the slot.
    bot_version: ?[]const u8 = null,

    /// A timestamp of the date and time that the slot was created.
    creation_date_time: ?i64 = null,

    /// The description specified for the slot.
    description: ?[]const u8 = null,

    /// The identifier of the intent associated with the slot.
    intent_id: ?[]const u8 = null,

    /// A timestamp of the date and time that the slot was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The language and locale specified for the slot.
    locale_id: ?[]const u8 = null,

    /// Indicates whether the slot accepts multiple values in a single
    /// utterance.
    ///
    /// If the `multipleValuesSetting` is not set, the default
    /// value is `false`.
    multiple_values_setting: ?MultipleValuesSetting = null,

    /// Whether slot values are shown in Amazon CloudWatch logs. If the value is
    /// `None`, the actual value of the slot is shown in
    /// logs.
    obfuscation_setting: ?ObfuscationSetting = null,

    /// The unique identifier generated for the slot.
    slot_id: ?[]const u8 = null,

    /// The name specified for the slot.
    slot_name: ?[]const u8 = null,

    /// The identifier of the slot type that determines the values entered
    /// into the slot.
    slot_type_id: ?[]const u8 = null,

    /// Specifications for the constituent sub slots and the
    /// expression for the composite slot.
    sub_slot_setting: ?SubSlotSetting = null,

    /// Prompts that Amazon Lex uses to elicit a value for the slot.
    value_elicitation_setting: ?SlotValueElicitationSetting = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .intent_id = "intentId",
        .last_updated_date_time = "lastUpdatedDateTime",
        .locale_id = "localeId",
        .multiple_values_setting = "multipleValuesSetting",
        .obfuscation_setting = "obfuscationSetting",
        .slot_id = "slotId",
        .slot_name = "slotName",
        .slot_type_id = "slotTypeId",
        .sub_slot_setting = "subSlotSetting",
        .value_elicitation_setting = "valueElicitationSetting",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSlotInput, options: CallOptions) !DescribeSlotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lex");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSlotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/intents/");
    try path_buf.appendSlice(allocator, input.intent_id);
    try path_buf.appendSlice(allocator, "/slots/");
    try path_buf.appendSlice(allocator, input.slot_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSlotOutput {
    var result: DescribeSlotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeSlotOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
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
