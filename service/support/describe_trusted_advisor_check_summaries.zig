const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrustedAdvisorCheckSummary = @import("trusted_advisor_check_summary.zig").TrustedAdvisorCheckSummary;

pub const DescribeTrustedAdvisorCheckSummariesInput = struct {
    /// The IDs of the Trusted Advisor checks.
    check_ids: []const []const u8,

    pub const json_field_names = .{
        .check_ids = "checkIds",
    };
};

pub const DescribeTrustedAdvisorCheckSummariesOutput = struct {
    /// The summary information for the requested Trusted Advisor checks.
    summaries: ?[]const TrustedAdvisorCheckSummary = null,

    pub const json_field_names = .{
        .summaries = "summaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrustedAdvisorCheckSummariesInput, options: CallOptions) !DescribeTrustedAdvisorCheckSummariesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrustedAdvisorCheckSummariesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeTrustedAdvisorCheckSummaries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrustedAdvisorCheckSummariesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeTrustedAdvisorCheckSummariesOutput, body, allocator);
}
