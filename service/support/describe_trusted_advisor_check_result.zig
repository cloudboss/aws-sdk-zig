const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrustedAdvisorCheckResult = @import("trusted_advisor_check_result.zig").TrustedAdvisorCheckResult;

pub const DescribeTrustedAdvisorCheckResultInput = struct {
    /// The unique identifier for the Trusted Advisor check.
    check_id: []const u8,

    /// The ISO 639-1 code for the language that you want your check results to
    /// appear
    /// in.
    ///
    /// The Amazon Web Services Support API currently supports the following
    /// languages for Trusted Advisor:
    ///
    /// * Chinese, Simplified - `zh`
    ///
    /// * Chinese, Traditional - `zh_TW`
    ///
    /// * English - `en`
    ///
    /// * French - `fr`
    ///
    /// * German - `de`
    ///
    /// * Indonesian - `id`
    ///
    /// * Italian - `it`
    ///
    /// * Japanese - `ja`
    ///
    /// * Korean - `ko`
    ///
    /// * Portuguese, Brazilian - `pt_BR`
    ///
    /// * Spanish - `es`
    language: ?[]const u8 = null,

    pub const json_field_names = .{
        .check_id = "checkId",
        .language = "language",
    };
};

pub const DescribeTrustedAdvisorCheckResultOutput = struct {
    /// The detailed results of the Trusted Advisor check.
    result: ?TrustedAdvisorCheckResult = null,

    pub const json_field_names = .{
        .result = "result",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrustedAdvisorCheckResultInput, options: CallOptions) !DescribeTrustedAdvisorCheckResultOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrustedAdvisorCheckResultInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeTrustedAdvisorCheckResult");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrustedAdvisorCheckResultOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTrustedAdvisorCheckResultOutput, body, allocator);
}
