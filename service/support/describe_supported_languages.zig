const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SupportedLanguage = @import("supported_language.zig").SupportedLanguage;

pub const DescribeSupportedLanguagesInput = struct {
    /// The category of problem for the support case. You also use the
    /// DescribeServices operation to get the category code for a service. Each
    /// Amazon Web Services service defines its own set of category codes.
    category_code: []const u8,

    /// Specifies whether to validate the request without actually returning
    /// supported languages.
    /// When set to `true`, the request is validated but no languages are returned,
    /// and the
    /// operation returns a `DryRunOperationException`. When omitted or set to
    /// `false`, the request runs normally.
    dry_run: ?bool = null,

    /// The type of issue for the case. You can specify `customer-service` or
    /// `technical`.
    issue_type: []const u8,

    /// The code for the Amazon Web Services service. You can use the
    /// DescribeServices
    /// operation to get the possible `serviceCode` values.
    service_code: []const u8,

    pub const json_field_names = .{
        .category_code = "categoryCode",
        .dry_run = "dryRun",
        .issue_type = "issueType",
        .service_code = "serviceCode",
    };
};

pub const DescribeSupportedLanguagesOutput = struct {
    /// A JSON-formatted array that contains the available ISO 639-1 language codes.
    supported_languages: ?[]const SupportedLanguage = null,

    pub const json_field_names = .{
        .supported_languages = "supportedLanguages",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSupportedLanguagesInput, options: CallOptions) !DescribeSupportedLanguagesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSupportedLanguagesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeSupportedLanguages");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSupportedLanguagesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSupportedLanguagesOutput, body, allocator);
}
