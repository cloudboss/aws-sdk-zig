const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetCertificateInput = struct {
    /// String that contains a certificate ARN in the following format:
    ///
    /// `arn:aws:acm:region:123456789012:certificate/12345678-1234-1234-1234-123456789012`
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    certificate_arn: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
    };
};

pub const GetCertificateOutput = struct {
    /// The ACM-issued certificate corresponding to the ARN specified as input.
    certificate: ?[]const u8 = null,

    /// Certificates forming the requested certificate's chain of trust. The chain
    /// consists of the certificate of the issuing CA and the intermediate
    /// certificates of any other subordinate CAs.
    certificate_chain: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate = "Certificate",
        .certificate_chain = "CertificateChain",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCertificateInput, options: CallOptions) !GetCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "acm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm", "ACM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.GetCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCertificateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCertificateOutput, body, allocator);
}
