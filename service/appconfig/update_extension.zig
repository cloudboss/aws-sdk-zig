const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const Parameter = @import("parameter.zig").Parameter;

pub const UpdateExtensionInput = struct {
    /// The actions defined in the extension.
    actions: ?[]const aws.map.MapEntry([]const Action) = null,

    /// Information about the extension.
    description: ?[]const u8 = null,

    /// The name, the ID, or the Amazon Resource Name (ARN) of the extension.
    extension_identifier: []const u8,

    /// One or more parameters for the actions called by the extension.
    parameters: ?[]const aws.map.MapEntry(Parameter) = null,

    /// The extension version number.
    version_number: ?i32 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .description = "Description",
        .extension_identifier = "ExtensionIdentifier",
        .parameters = "Parameters",
        .version_number = "VersionNumber",
    };
};

pub const UpdateExtensionOutput = struct {
    /// The actions defined in the extension.
    actions: ?[]const aws.map.MapEntry([]const Action) = null,

    /// The system-generated Amazon Resource Name (ARN) for the extension.
    arn: ?[]const u8 = null,

    /// Information about the extension.
    description: ?[]const u8 = null,

    /// The system-generated ID of the extension.
    id: ?[]const u8 = null,

    /// The extension name.
    name: ?[]const u8 = null,

    /// The parameters accepted by the extension. You specify parameter values when
    /// you
    /// associate the extension to an AppConfig resource by using the
    /// `CreateExtensionAssociation` API action. For Lambda extension
    /// actions, these parameters are included in the Lambda request object.
    parameters: ?[]const aws.map.MapEntry(Parameter) = null,

    /// The extension version number.
    version_number: ?i32 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .parameters = "Parameters",
        .version_number = "VersionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateExtensionInput, options: CallOptions) !UpdateExtensionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateExtensionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/extensions/");
    try path_buf.appendSlice(allocator, input.extension_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.actions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Actions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VersionNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateExtensionOutput {
    var result: UpdateExtensionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateExtensionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
