const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionDefinitionVersion = @import("function_definition_version.zig").FunctionDefinitionVersion;

pub const CreateFunctionDefinitionInput = struct {
    /// A client token used to correlate requests and responses.
    amzn_client_token: ?[]const u8 = null,

    /// Information about the initial version of the function definition.
    initial_version: ?FunctionDefinitionVersion = null,

    /// The name of the function definition.
    name: ?[]const u8 = null,

    /// Tag(s) to add to the new resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .amzn_client_token = "AmznClientToken",
        .initial_version = "InitialVersion",
        .name = "Name",
        .tags = "tags",
    };
};

pub const CreateFunctionDefinitionOutput = struct {
    /// The ARN of the definition.
    arn: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the definition was created.
    creation_timestamp: ?[]const u8 = null,

    /// The ID of the definition.
    id: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the definition was last
    /// updated.
    last_updated_timestamp: ?[]const u8 = null,

    /// The ID of the latest version associated with the definition.
    latest_version: ?[]const u8 = null,

    /// The ARN of the latest version associated with the definition.
    latest_version_arn: ?[]const u8 = null,

    /// The name of the definition.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_timestamp = "CreationTimestamp",
        .id = "Id",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .latest_version = "LatestVersion",
        .latest_version_arn = "LatestVersionArn",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFunctionDefinitionInput, options: CallOptions) !CreateFunctionDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFunctionDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/greengrass/definition/functions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.initial_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InitialVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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
    if (input.amzn_client_token) |v| {
        try request.headers.put(allocator, "X-Amzn-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFunctionDefinitionOutput {
    const result: CreateFunctionDefinitionOutput = try aws.json.parseJsonObject(
        CreateFunctionDefinitionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
