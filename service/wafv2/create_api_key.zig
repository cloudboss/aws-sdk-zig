const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;

pub const CreateAPIKeyInput = struct {
    /// Specifies whether this is for a global resource type, such as a Amazon
    /// CloudFront distribution. For an Amplify application, use `CLOUDFRONT`.
    ///
    /// To work with CloudFront, you must also specify the Region US East (N.
    /// Virginia) as follows:
    ///
    /// * CLI - Specify the Region when you use the CloudFront scope:
    ///   `--scope=CLOUDFRONT --region=us-east-1`.
    ///
    /// * API and SDKs - For all calls, use the Region endpoint us-east-1.
    scope: Scope,

    /// The client application domains that you want to use this API key for.
    ///
    /// Example JSON: `"TokenDomains": ["abc.com", "store.abc.com"]`
    ///
    /// Public suffixes aren't allowed. For example, you can't use `gov.au` or
    /// `co.uk` as token domains.
    token_domains: []const []const u8,

    pub const json_field_names = .{
        .scope = "Scope",
        .token_domains = "TokenDomains",
    };
};

pub const CreateAPIKeyOutput = struct {
    /// The generated, encrypted API key. You can copy this for use in your
    /// JavaScript CAPTCHA integration.
    api_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_key = "APIKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAPIKeyInput, options: CallOptions) !CreateAPIKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAPIKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.CreateAPIKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAPIKeyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAPIKeyOutput, body, allocator);
}
