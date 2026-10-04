const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutPolicyInput = struct {
    /// The path and file name of a JSON-formatted IAM policy to attach to the
    /// specified private CA resource. If this policy does not contain all required
    /// statements or if it includes any statement that is not allowed, the
    /// `PutPolicy` action returns an `InvalidPolicyException`. For information
    /// about IAM policy and statement structure, see [Overview of JSON
    /// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#access_policies-json).
    policy: []const u8,

    /// The Amazon Resource Number (ARN) of the private CA to associate with the
    /// policy. The ARN of the CA can be found by calling the
    /// [ListCertificateAuthorities](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListCertificateAuthorities.html) action.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};

pub const PutPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPolicyInput, options: CallOptions) !PutPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.PutPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
