const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const LayoutConfiguration = @import("layout_configuration.zig").LayoutConfiguration;
const Composition = @import("composition.zig").Composition;

pub const StartCompositionInput = struct {
    /// Array of destination configuration.
    destinations: []const DestinationConfiguration,

    /// Idempotency token.
    idempotency_token: ?[]const u8 = null,

    /// Layout object to configure composition parameters.
    layout: ?LayoutConfiguration = null,

    /// ARN of the stage to be used for compositing.
    stage_arn: []const u8,

    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging AWS Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no constraints on tags beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .destinations = "destinations",
        .idempotency_token = "idempotencyToken",
        .layout = "layout",
        .stage_arn = "stageArn",
        .tags = "tags",
    };
};

pub const StartCompositionOutput = struct {
    /// The Composition that was created.
    composition: ?Composition = null,

    pub const json_field_names = .{
        .composition = "composition",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCompositionInput, options: CallOptions) !StartCompositionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCompositionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartComposition";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinations\":");
    try aws.json.writeValue(@TypeOf(input.destinations), input.destinations, allocator, &body_buf);
    has_prev = true;
    if (input.idempotency_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idempotencyToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.layout) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"layout\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stageArn\":");
    try aws.json.writeValue(@TypeOf(input.stage_arn), input.stage_arn, allocator, &body_buf);
    has_prev = true;
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCompositionOutput {
    const result: StartCompositionOutput = try aws.json.parseJsonObject(
        StartCompositionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
