const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Permission = @import("permission.zig").Permission;

pub const ListPermissionsInput = struct {
    /// The Amazon Resource Number (ARN) of the private CA to inspect. You can find
    /// the ARN by calling the
    /// [ListCertificateAuthorities](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListCertificateAuthorities.html) action. This must be of the form: `arn:aws:acm-pca:region:account:certificate-authority/12345678-1234-1234-1234-123456789012` You can get a private CA's ARN by running the [ListCertificateAuthorities](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListCertificateAuthorities.html) action.
    certificate_authority_arn: []const u8,

    /// When paginating results, use this parameter to specify the maximum number of
    /// items to return in the response. If additional items exist beyond the number
    /// you specify, the **NextToken** element is sent in the response. Use this
    /// **NextToken** value in a subsequent request to retrieve additional items.
    max_results: ?i32 = null,

    /// When paginating results, use this parameter in a subsequent request after
    /// you receive a response with truncated results. Set it to the value of
    /// **NextToken** from the response you just received.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListPermissionsOutput = struct {
    /// When the list is truncated, this value is present and should be used for the
    /// **NextToken** parameter in a subsequent pagination request.
    next_token: ?[]const u8 = null,

    /// Summary information about each permission assigned by the specified private
    /// CA, including the action enabled, the policy provided, and the time of
    /// creation.
    permissions: ?[]const Permission = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .permissions = "Permissions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPermissionsInput, options: CallOptions) !ListPermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "acm-pca", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm-pca", "ACM PCA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.ListPermissions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPermissionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPermissionsOutput, body, allocator);
}
