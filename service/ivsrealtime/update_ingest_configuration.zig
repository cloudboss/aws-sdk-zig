const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngestConfiguration = @import("ingest_configuration.zig").IngestConfiguration;

pub const UpdateIngestConfigurationInput = struct {
    /// ARN of the IngestConfiguration, for which the related stage ARN needs to be
    /// updated.
    arn: []const u8,

    /// Indicates whether redundant ingest is enabled for the ingest configuration.
    /// Default: `false`.
    redundant_ingest: ?bool = null,

    /// Stage ARN that needs to be updated.
    stage_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .redundant_ingest = "redundantIngest",
        .stage_arn = "stageArn",
    };
};

pub const UpdateIngestConfigurationOutput = struct {
    /// See
    /// [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Access-Control-Allow-Origin) in the MDN Web Docs.
    access_control_allow_origin: ?[]const u8 = null,

    /// See
    /// [Access-Control-Expose-Headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Access-Control-Expose-Headers) in the MDN Web Docs.
    access_control_expose_headers: ?[]const u8 = null,

    /// See
    /// [Cache-Control](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cache-Control) in the MDN Web Docs.
    cache_control: ?[]const u8 = null,

    /// See
    /// [Content-Security-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy) in the MDN Web Docs.
    content_security_policy: ?[]const u8 = null,

    /// The updated IngestConfiguration.
    ingest_configuration: ?IngestConfiguration = null,

    /// See
    /// [Strict-Transport-Security](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Strict-Transport-Security) in the MDN Web Docs.
    strict_transport_security: ?[]const u8 = null,

    /// See
    /// [X-Content-Type-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Content-Type-Options) in the MDN Web Docs.
    x_content_type_options: ?[]const u8 = null,

    /// See
    /// [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Frame-Options) in the MDN Web Docs.
    x_frame_options: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_control_allow_origin = "accessControlAllowOrigin",
        .access_control_expose_headers = "accessControlExposeHeaders",
        .cache_control = "cacheControl",
        .content_security_policy = "contentSecurityPolicy",
        .ingest_configuration = "ingestConfiguration",
        .strict_transport_security = "strictTransportSecurity",
        .x_content_type_options = "xContentTypeOptions",
        .x_frame_options = "xFrameOptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIngestConfigurationInput, options: CallOptions) !UpdateIngestConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIngestConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateIngestConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.redundant_ingest) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"redundantIngest\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stage_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stageArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIngestConfigurationOutput {
    var result: UpdateIngestConfigurationOutput = try aws.json.parseJsonObject(
        UpdateIngestConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    if (headers.get("access-control-allow-origin")) |value| {
        result.access_control_allow_origin = try allocator.dupe(u8, value);
    }
    if (headers.get("access-control-expose-headers")) |value| {
        result.access_control_expose_headers = try allocator.dupe(u8, value);
    }
    if (headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
    }
    if (headers.get("content-security-policy")) |value| {
        result.content_security_policy = try allocator.dupe(u8, value);
    }
    if (headers.get("strict-transport-security")) |value| {
        result.strict_transport_security = try allocator.dupe(u8, value);
    }
    if (headers.get("x-content-type-options")) |value| {
        result.x_content_type_options = try allocator.dupe(u8, value);
    }
    if (headers.get("x-frame-options")) |value| {
        result.x_frame_options = try allocator.dupe(u8, value);
    }

    return result;
}
