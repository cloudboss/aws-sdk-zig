const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AudienceSize = @import("audience_size.zig").AudienceSize;

pub const StartAudienceExportJobInput = struct {
    /// The Amazon Resource Name (ARN) of the audience generation job that you want
    /// to export.
    audience_generation_job_arn: []const u8,

    audience_size: AudienceSize,

    /// The description of the audience export job.
    description: ?[]const u8 = null,

    /// The name of the audience export job.
    name: []const u8,

    pub const json_field_names = .{
        .audience_generation_job_arn = "audienceGenerationJobArn",
        .audience_size = "audienceSize",
        .description = "description",
        .name = "name",
    };
};

pub const StartAudienceExportJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAudienceExportJobInput, options: CallOptions) !StartAudienceExportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms-ml", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAudienceExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audience-export-job";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"audienceGenerationJobArn\":");
    try aws.json.writeValue(@TypeOf(input.audience_generation_job_arn), input.audience_generation_job_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"audienceSize\":");
    try aws.json.writeValue(@TypeOf(input.audience_size), input.audience_size, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAudienceExportJobOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: StartAudienceExportJobOutput = .{};

    return result;
}
