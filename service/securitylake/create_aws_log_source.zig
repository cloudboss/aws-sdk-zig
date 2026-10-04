const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AwsLogSourceConfiguration = @import("aws_log_source_configuration.zig").AwsLogSourceConfiguration;

pub const CreateAwsLogSourceInput = struct {
    /// Specify the natively-supported Amazon Web Services service to add as a
    /// source in Security Lake.
    sources: []const AwsLogSourceConfiguration,

    pub const json_field_names = .{
        .sources = "sources",
    };
};

pub const CreateAwsLogSourceOutput = struct {
    /// Lists all accounts in which enabling a natively supported Amazon Web
    /// Services service as
    /// a Security Lake source failed. The failure occurred as these accounts are
    /// not part of an
    /// organization.
    failed: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .failed = "failed",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAwsLogSourceInput, options: CallOptions) !CreateAwsLogSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securitylake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAwsLogSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securitylake", "SecurityLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/datalake/logsources/aws";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sources\":");
    try aws.json.writeValue(@TypeOf(input.sources), input.sources, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAwsLogSourceOutput {
    var result: CreateAwsLogSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAwsLogSourceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
