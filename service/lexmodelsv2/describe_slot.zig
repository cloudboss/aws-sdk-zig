const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSlotInput, config: *aws.Config) !aws.http.Request {
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

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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
