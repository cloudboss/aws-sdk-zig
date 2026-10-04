const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultipleValuesSetting = @import("multiple_values_setting.zig").MultipleValuesSetting;
const ObfuscationSetting = @import("obfuscation_setting.zig").ObfuscationSetting;
const SubSlotSetting = @import("sub_slot_setting.zig").SubSlotSetting;
const SlotValueElicitationSetting = @import("slot_value_elicitation_setting.zig").SlotValueElicitationSetting;

pub const CreateSlotInput = struct {
    /// The identifier of the bot associated with the slot.
    bot_id: []const u8,

    /// The version of the bot associated with the slot.
    bot_version: []const u8,

    /// A description of the slot. Use this to help identify the slot in
    /// lists.
    description: ?[]const u8 = null,

    /// The identifier of the intent that contains the slot.
    intent_id: []const u8,

    /// The identifier of the language and locale that the slot will be used
    /// in. The string must match one of the supported locales. All of the
    /// bots, intents, slot types used by the slot must have the same locale.
    /// For more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// Indicates whether the slot returns multiple values in one response.
    /// Multi-value slots are only available in the `en-US` locale.
    /// If you set this value to `true` in any other locale, Amazon Lex throws a
    /// `ValidationException`.
    ///
    /// If the `multipleValuesSetting` is not set, the default
    /// value is `false`.
    multiple_values_setting: ?MultipleValuesSetting = null,

    /// Determines how slot values are used in Amazon CloudWatch logs. If the value
    /// of
    /// the `obfuscationSetting` parameter is
    /// `DefaultObfuscation`, slot values are obfuscated in the
    /// log output. If the value is `None`, the actual value is
    /// present in the log output.
    ///
    /// The default is to obfuscate values in the CloudWatch logs.
    obfuscation_setting: ?ObfuscationSetting = null,

    /// The name of the slot. Slot names must be unique within the bot that
    /// contains the slot.
    slot_name: []const u8,

    /// The unique identifier for the slot type associated with this slot.
    /// The slot type determines the values that can be entered into the
    /// slot.
    slot_type_id: ?[]const u8 = null,

    /// Specifications for the constituent sub slots and the
    /// expression for the composite slot.
    sub_slot_setting: ?SubSlotSetting = null,

    /// Specifies prompts that Amazon Lex sends to the user to elicit a response
    /// that provides the value for the slot.
    value_elicitation_setting: SlotValueElicitationSetting,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .description = "description",
        .intent_id = "intentId",
        .locale_id = "localeId",
        .multiple_values_setting = "multipleValuesSetting",
        .obfuscation_setting = "obfuscationSetting",
        .slot_name = "slotName",
        .slot_type_id = "slotTypeId",
        .sub_slot_setting = "subSlotSetting",
        .value_elicitation_setting = "valueElicitationSetting",
    };
};

pub const CreateSlotOutput = struct {
    /// The unique identifier of the bot associated with the slot.
    bot_id: ?[]const u8 = null,

    /// The version of the bot associated with the slot.
    bot_version: ?[]const u8 = null,

    /// The timestamp of the date and time that the slot was created.
    creation_date_time: ?i64 = null,

    /// The description associated with the slot.
    description: ?[]const u8 = null,

    /// The unique identifier of the intent associated with the slot.
    intent_id: ?[]const u8 = null,

    /// The language and local specified for the slot.
    locale_id: ?[]const u8 = null,

    /// Indicates whether the slot returns multiple values in one
    /// response.
    multiple_values_setting: ?MultipleValuesSetting = null,

    /// Indicates whether the slot is configured to obfuscate values in Amazon
    /// CloudWatch
    /// logs.
    obfuscation_setting: ?ObfuscationSetting = null,

    /// The unique identifier associated with the slot. Use this to identify
    /// the slot when you update or delete it.
    slot_id: ?[]const u8 = null,

    /// The name specified for the slot.
    slot_name: ?[]const u8 = null,

    /// The unique identifier of the slot type associated with this
    /// slot.
    slot_type_id: ?[]const u8 = null,

    /// Specifications for the constituent sub slots and the
    /// expression for the composite slot.
    sub_slot_setting: ?SubSlotSetting = null,

    /// The value elicitation settings specified for the slot.
    value_elicitation_setting: ?SlotValueElicitationSetting = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSlotInput, options: CallOptions) !CreateSlotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSlotInput, config: *aws.Config) !aws.http.Request {
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
    try path_buf.appendSlice(allocator, "/slots");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSlotOutput {
    var result: CreateSlotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSlotOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
