const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PresetSettings = @import("preset_settings.zig").PresetSettings;
const Preset = @import("preset.zig").Preset;

pub const CreatePresetInput = struct {
    /// Optional. A category for the preset you are creating.
    category: ?[]const u8 = null,

    /// Optional. A description of the preset you are creating.
    description: ?[]const u8 = null,

    /// The name of the preset you are creating.
    name: []const u8,

    /// Settings for preset
    settings: PresetSettings,

    /// The tags that you want to add to the resource. You can tag resources with a
    /// key-value pair or with only a key.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .category = "Category",
        .description = "Description",
        .name = "Name",
        .settings = "Settings",
        .tags = "Tags",
    };
};

pub const CreatePresetOutput = struct {
    /// A preset is a collection of preconfigured media conversion settings that you
    /// want MediaConvert to apply to the output during the conversion process.
    preset: ?Preset = null,

    pub const json_field_names = .{
        .preset = "Preset",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePresetInput, options: CallOptions) !CreatePresetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconvert", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePresetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconvert", "MediaConvert", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2017-08-29/presets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.category) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Category\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Settings\":");
    try aws.json.writeValue(@TypeOf(input.settings), input.settings, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePresetOutput {
    var result: CreatePresetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePresetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
