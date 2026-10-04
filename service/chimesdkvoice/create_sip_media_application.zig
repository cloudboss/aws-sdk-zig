const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SipMediaApplicationEndpoint = @import("sip_media_application_endpoint.zig").SipMediaApplicationEndpoint;
const Tag = @import("tag.zig").Tag;
const SipMediaApplication = @import("sip_media_application.zig").SipMediaApplication;

pub const CreateSipMediaApplicationInput = struct {
    /// The AWS Region assigned to the SIP media application.
    aws_region: []const u8,

    /// List of endpoints (Lambda ARNs) specified for the SIP media application.
    endpoints: []const SipMediaApplicationEndpoint,

    /// The SIP media application's name.
    name: []const u8,

    /// The tags assigned to the SIP media application.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aws_region = "AwsRegion",
        .endpoints = "Endpoints",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateSipMediaApplicationOutput = struct {
    /// The SIP media application details.
    sip_media_application: ?SipMediaApplication = null,

    pub const json_field_names = .{
        .sip_media_application = "SipMediaApplication",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSipMediaApplicationInput, options: CallOptions) !CreateSipMediaApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSipMediaApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sip-media-applications";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AwsRegion\":");
    try aws.json.writeValue(@TypeOf(input.aws_region), input.aws_region, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Endpoints\":");
    try aws.json.writeValue(@TypeOf(input.endpoints), input.endpoints, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSipMediaApplicationOutput {
    var result: CreateSipMediaApplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSipMediaApplicationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
