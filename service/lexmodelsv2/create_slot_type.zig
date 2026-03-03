const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CompositeSlotTypeSetting = @import("composite_slot_type_setting.zig").CompositeSlotTypeSetting;
const ExternalSourceSetting = @import("external_source_setting.zig").ExternalSourceSetting;
const SlotTypeValue = @import("slot_type_value.zig").SlotTypeValue;
const SlotValueSelectionSetting = @import("slot_value_selection_setting.zig").SlotValueSelectionSetting;

pub const CreateSlotTypeInput = struct {
    /// The identifier of the bot associated with this slot type.
    bot_id: []const u8,

    /// The identifier of the bot version associated with this slot
    /// type.
    bot_version: []const u8,

    /// Specifications for a composite slot type.
    composite_slot_type_setting: ?CompositeSlotTypeSetting = null,

    /// A description of the slot type. Use the description to help identify
    /// the slot type in lists.
    description: ?[]const u8 = null,

    /// Sets the type of external information used to create the slot
    /// type.
    external_source_setting: ?ExternalSourceSetting = null,

    /// The identifier of the language and locale that the slot type will be
    /// used in. The string must match one of the supported locales. All of the
    /// bots, intents, and slots used by the slot type must have the same
    /// locale. For more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// The built-in slot type used as a parent of this slot type. When you
    /// define a parent slot type, the new slot type has the configuration of
    /// the parent slot type.
    ///
    /// Only `AMAZON.AlphaNumeric` is supported.
    parent_slot_type_signature: ?[]const u8 = null,

    /// The name for the slot. A slot type name must be unique within the
    /// intent.
    slot_type_name: []const u8,

    /// A list of `SlotTypeValue` objects that defines the values
    /// that the slot type can take. Each value can have a list of synonyms,
    /// additional values that help train the machine learning model about the
    /// values that it resolves for a slot.
    slot_type_values: ?[]const SlotTypeValue = null,

    /// Determines the strategy that Amazon Lex uses to select a value from the
    /// list of possible values. The field can be set to one of the following
    /// values:
    ///
    /// * `ORIGINAL_VALUE` - Returns the value entered by the
    /// user, if the user value is similar to the slot value.
    ///
    /// * `TOP_RESOLUTION` - If there is a resolution list for
    /// the slot, return the first value in the resolution list. If there
    /// is no resolution list, return null.
    ///
    /// If you don't specify the `valueSelectionSetting`
    /// parameter, the default is `ORIGINAL_VALUE`.
    value_selection_setting: ?SlotValueSelectionSetting = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .composite_slot_type_setting = "compositeSlotTypeSetting",
        .description = "description",
        .external_source_setting = "externalSourceSetting",
        .locale_id = "localeId",
        .parent_slot_type_signature = "parentSlotTypeSignature",
        .slot_type_name = "slotTypeName",
        .slot_type_values = "slotTypeValues",
        .value_selection_setting = "valueSelectionSetting",
    };
};

pub const CreateSlotTypeOutput = struct {
    /// The identifier for the bot associated with the slot type.
    bot_id: ?[]const u8 = null,

    /// The version of the bot associated with the slot type.
    bot_version: ?[]const u8 = null,

    /// Specifications for a composite slot type.
    composite_slot_type_setting: ?CompositeSlotTypeSetting = null,

    /// A timestamp of the date and time that the slot type was
    /// created.
    creation_date_time: ?i64 = null,

    /// The description specified for the slot type.
    description: ?[]const u8 = null,

    /// The type of external information used to create the slot
    /// type.
    external_source_setting: ?ExternalSourceSetting = null,

    /// The specified language and local specified for the slot type.
    locale_id: ?[]const u8 = null,

    /// The signature of the base slot type specified for the slot
    /// type.
    parent_slot_type_signature: ?[]const u8 = null,

    /// The unique identifier assigned to the slot type. Use this to
    /// identify the slot type in the `UpdateSlotType` and
    /// `DeleteSlotType` operations.
    slot_type_id: ?[]const u8 = null,

    /// The name specified for the slot type.
    slot_type_name: ?[]const u8 = null,

    /// The list of values that the slot type can assume.
    slot_type_values: ?[]const SlotTypeValue = null,

    /// The strategy that Amazon Lex uses to select a value from the list of
    /// possible values.
    value_selection_setting: ?SlotValueSelectionSetting = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .composite_slot_type_setting = "compositeSlotTypeSetting",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .external_source_setting = "externalSourceSetting",
        .locale_id = "localeId",
        .parent_slot_type_signature = "parentSlotTypeSignature",
        .slot_type_id = "slotTypeId",
        .slot_type_name = "slotTypeName",
        .slot_type_values = "slotTypeValues",
        .value_selection_setting = "valueSelectionSetting",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSlotTypeInput, options: Options) !CreateSlotTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelsv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSlotTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", allocator);

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
    try path_buf.appendSlice(allocator, "/slottypes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.composite_slot_type_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"compositeSlotTypeSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.external_source_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"externalSourceSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_slot_type_signature) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentSlotTypeSignature\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"slotTypeName\":");
    try aws.json.writeValue(@TypeOf(input.slot_type_name), input.slot_type_name, allocator, &body_buf);
    has_prev = true;
    if (input.slot_type_values) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"slotTypeValues\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.value_selection_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"valueSelectionSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSlotTypeOutput {
    var result: CreateSlotTypeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSlotTypeOutput, body, allocator);
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
