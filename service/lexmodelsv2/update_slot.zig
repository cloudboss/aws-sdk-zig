const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultipleValuesSetting = @import("multiple_values_setting.zig").MultipleValuesSetting;
const ObfuscationSetting = @import("obfuscation_setting.zig").ObfuscationSetting;
const SubSlotSetting = @import("sub_slot_setting.zig").SubSlotSetting;
const SlotValueElicitationSetting = @import("slot_value_elicitation_setting.zig").SlotValueElicitationSetting;

pub const UpdateSlotInput = struct {
    /// The unique identifier of the bot that contains the slot.
    bot_id: []const u8,

    /// The version of the bot that contains the slot. Must always be
    /// `DRAFT`.
    bot_version: []const u8,

    /// The new description for the slot.
    description: ?[]const u8 = null,

    /// The identifier of the intent that contains the slot.
    intent_id: []const u8,

    /// The identifier of the language and locale that contains the slot.
    /// The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// Determines whether the slot accepts multiple values in one response.
    /// Multiple value slots are only available in the en-US locale. If you set
    /// this value to `true` in any other locale, Amazon Lex throws a
    /// `ValidationException`.
    ///
    /// If the `multipleValuesSetting` is not set, the default
    /// value is `false`.
    multiple_values_setting: ?MultipleValuesSetting = null,

    /// New settings that determine how slot values are formatted in Amazon
    /// CloudWatch
    /// logs.
    obfuscation_setting: ?ObfuscationSetting = null,

    /// The unique identifier for the slot to update.
    slot_id: []const u8,

    /// The new name for the slot.
    slot_name: []const u8,

    /// The unique identifier of the new slot type to associate with this
    /// slot.
    slot_type_id: ?[]const u8 = null,

    /// Specifications for the constituent sub slots and the
    /// expression for the composite slot.
    sub_slot_setting: ?SubSlotSetting = null,

    /// A new set of prompts that Amazon Lex sends to the user to elicit a
    /// response the provides a value for the slot.
    value_elicitation_setting: SlotValueElicitationSetting,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .description = "description",
        .intent_id = "intentId",
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

pub const UpdateSlotOutput = struct {
    /// The identifier of the bot that contains the slot.
    bot_id: ?[]const u8 = null,

    /// The version of the bot that contains the slot. Will
    /// always be `DRAFT`.
    bot_version: ?[]const u8 = null,

    /// The timestamp of the date and time that the slot was created.
    creation_date_time: ?i64 = null,

    /// The updated description of the bot.
    description: ?[]const u8 = null,

    /// The intent that contains the slot.
    intent_id: ?[]const u8 = null,

    /// The timestamp of the date and time that the slot was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The locale that contains the slot.
    locale_id: ?[]const u8 = null,

    /// Indicates whether the slot accepts multiple values in one
    /// response.
    multiple_values_setting: ?MultipleValuesSetting = null,

    /// The updated setting that determines whether the slot value is
    /// obfuscated in the Amazon CloudWatch logs.
    obfuscation_setting: ?ObfuscationSetting = null,

    /// The unique identifier of the slot that was updated.
    slot_id: ?[]const u8 = null,

    /// The updated name of the slot.
    slot_name: ?[]const u8 = null,

    /// The updated identifier of the slot type that provides values for the
    /// slot.
    slot_type_id: ?[]const u8 = null,

    /// Specifications for the constituent sub slots and the
    /// expression for the composite slot.
    sub_slot_setting: ?SubSlotSetting = null,

    /// The updated prompts that Amazon Lex sends to the user to elicit a
    /// response that provides a value for the slot.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSlotInput, options: CallOptions) !UpdateSlotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSlotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multiple_values_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"multipleValuesSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.obfuscation_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"obfuscationSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"slotName\":");
    try aws.json.writeValue(@TypeOf(input.slot_name), input.slot_name, allocator, &body_buf);
    has_prev = true;
    if (input.slot_type_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"slotTypeId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sub_slot_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subSlotSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"valueElicitationSetting\":");
    try aws.json.writeValue(@TypeOf(input.value_elicitation_setting), input.value_elicitation_setting, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSlotOutput {
    const result: UpdateSlotOutput = try aws.json.parseJsonObject(
        UpdateSlotOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
