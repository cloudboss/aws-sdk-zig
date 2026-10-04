const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Regex = @import("regex.zig").Regex;
const Scope = @import("scope.zig").Scope;
const Tag = @import("tag.zig").Tag;
const RegexPatternSetSummary = @import("regex_pattern_set_summary.zig").RegexPatternSetSummary;

pub const CreateRegexPatternSetInput = struct {
    /// A description of the set that helps with identification.
    description: ?[]const u8 = null,

    /// The name of the set. You cannot change the name after you create the set.
    name: []const u8,

    /// Array of regular expression strings.
    regular_expression_list: []const Regex,

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

    /// An array of key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .regular_expression_list = "RegularExpressionList",
        .scope = "Scope",
        .tags = "Tags",
    };
};

pub const CreateRegexPatternSetOutput = struct {
    /// High-level information about a RegexPatternSet, returned by operations like
    /// create and list. This provides information like the ID, that you can use to
    /// retrieve and manage a `RegexPatternSet`, and the ARN, that you provide to
    /// the RegexPatternSetReferenceStatement to use the pattern set in a Rule.
    summary: ?RegexPatternSetSummary = null,

    pub const json_field_names = .{
        .summary = "Summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegexPatternSetInput, options: CallOptions) !CreateRegexPatternSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegexPatternSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.CreateRegexPatternSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegexPatternSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRegexPatternSetOutput, body, allocator);
}
