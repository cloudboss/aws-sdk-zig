const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlueprintStage = @import("blueprint_stage.zig").BlueprintStage;

pub const CopyBlueprintStageInput = struct {
    /// Blueprint to be copied
    blueprint_arn: []const u8,

    /// Client token for idempotency
    client_token: ?[]const u8 = null,

    /// Source stage to copy from
    source_stage: BlueprintStage,

    /// Target stage to copy to
    target_stage: BlueprintStage,

    pub const json_field_names = .{
        .blueprint_arn = "blueprintArn",
        .client_token = "clientToken",
        .source_stage = "sourceStage",
        .target_stage = "targetStage",
    };
};

pub const CopyBlueprintStageOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyBlueprintStageInput, options: CallOptions) !CopyBlueprintStageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyBlueprintStageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-data-automation", "Bedrock Data Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/blueprints/");
    try path_buf.appendSlice(allocator, input.blueprint_arn);
    try path_buf.appendSlice(allocator, "/copy-stage");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceStage\":");
    try aws.json.writeValue(@TypeOf(input.source_stage), input.source_stage, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetStage\":");
    try aws.json.writeValue(@TypeOf(input.target_stage), input.target_stage, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyBlueprintStageOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CopyBlueprintStageOutput = .{};

    return result;
}
