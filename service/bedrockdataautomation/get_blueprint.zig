const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlueprintStage = @import("blueprint_stage.zig").BlueprintStage;
const Blueprint = @import("blueprint.zig").Blueprint;

pub const GetBlueprintInput = struct {
    /// ARN generated at the server side when a Blueprint is created
    blueprint_arn: []const u8,

    /// Optional field to get a specific Blueprint stage
    blueprint_stage: ?BlueprintStage = null,

    /// Optional field to get a specific Blueprint version
    blueprint_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .blueprint_arn = "blueprintArn",
        .blueprint_stage = "blueprintStage",
        .blueprint_version = "blueprintVersion",
    };
};

pub const GetBlueprintOutput = struct {
    blueprint: ?Blueprint = null,

    pub const json_field_names = .{
        .blueprint = "blueprint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBlueprintInput, options: CallOptions) !GetBlueprintOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBlueprintInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-data-automation", "Bedrock Data Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/blueprints/");
    try path_buf.appendSlice(allocator, input.blueprint_arn);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.blueprint_stage) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blueprintStage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.blueprint_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blueprintVersion\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBlueprintOutput {
    var result: GetBlueprintOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBlueprintOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
