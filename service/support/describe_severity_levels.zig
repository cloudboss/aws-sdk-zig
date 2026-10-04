const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SeverityLevel = @import("severity_level.zig").SeverityLevel;

pub const DescribeSeverityLevelsInput = struct {
    /// The language in which Amazon Web Services Support handles the case. Amazon
    /// Web Services Support
    /// currently supports Chinese (“zh”), English ("en"), Japanese ("ja") and
    /// Korean (“ko”). You must specify the ISO 639-1
    /// code for the `language` parameter if you want support in that language.
    language: ?[]const u8 = null,

    pub const json_field_names = .{
        .language = "language",
    };
};

pub const DescribeSeverityLevelsOutput = struct {
    /// The available severity levels for the support case. Available severity
    /// levels are
    /// defined by your service level agreement with Amazon Web Services.
    severity_levels: ?[]const SeverityLevel = null,

    pub const json_field_names = .{
        .severity_levels = "severityLevels",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSeverityLevelsInput, options: CallOptions) !DescribeSeverityLevelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "support", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSeverityLevelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("support", "Support", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeSeverityLevels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSeverityLevelsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSeverityLevelsOutput, body, allocator);
}
