const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TermsEnforcementType = @import("terms_enforcement_type.zig").TermsEnforcementType;
const TermsSourceType = @import("terms_source_type.zig").TermsSourceType;
const TermsType = @import("terms_type.zig").TermsType;

pub const CreateTermsInput = struct {
    /// The ID of the app client where you want to create terms documents. Must be
    /// an app
    /// client in the requested user pool.
    client_id: []const u8,

    /// This parameter is reserved for future use and currently accepts only one
    /// value.
    enforcement: TermsEnforcementType,

    /// A map of URLs to languages. For each localized language that will view the
    /// requested
    /// `TermsName`, assign a URL. A selection of `cognito:default`
    /// displays for all languages that don't have a language-specific URL.
    ///
    /// For example, `"cognito:default": "https://terms.example.com",
    /// "cognito:spanish":
    /// "https://terms.example.com/es"`.
    links: ?[]const aws.map.StringMapEntry = null,

    /// A friendly name for the document that you want to create in the current
    /// request. Must
    /// begin with `terms-of-use` or `privacy-policy` as identification of
    /// the document type. Provide URLs for both `terms-of-use` and
    /// `privacy-policy` in separate requests.
    terms_name: []const u8,

    /// This parameter is reserved for future use and currently accepts only one
    /// value.
    terms_source: TermsSourceType,

    /// The ID of the user pool where you want to create terms documents.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .enforcement = "Enforcement",
        .links = "Links",
        .terms_name = "TermsName",
        .terms_source = "TermsSource",
        .user_pool_id = "UserPoolId",
    };
};

pub const CreateTermsOutput = struct {
    /// A summary of your terms documents. Includes a unique identifier for later
    /// changes to
    /// the terms documents.
    terms: ?TermsType = null,

    pub const json_field_names = .{
        .terms = "Terms",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTermsInput, options: CallOptions) !CreateTermsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTermsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.CreateTerms");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTermsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTermsOutput, body, allocator);
}
