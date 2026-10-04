const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeLunaClientInput = struct {
    /// The certificate fingerprint.
    certificate_fingerprint: ?[]const u8 = null,

    /// The ARN of the client.
    client_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_fingerprint = "CertificateFingerprint",
        .client_arn = "ClientArn",
    };
};

pub const DescribeLunaClientOutput = struct {
    /// The certificate installed on the HSMs used by this client.
    certificate: ?[]const u8 = null,

    /// The certificate fingerprint.
    certificate_fingerprint: ?[]const u8 = null,

    /// The ARN of the client.
    client_arn: ?[]const u8 = null,

    /// The label of the client.
    label: ?[]const u8 = null,

    /// The date and time the client was last modified.
    last_modified_timestamp: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate = "Certificate",
        .certificate_fingerprint = "CertificateFingerprint",
        .client_arn = "ClientArn",
        .label = "Label",
        .last_modified_timestamp = "LastModifiedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLunaClientInput, options: CallOptions) !DescribeLunaClientOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudhsm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLunaClientInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsm", "CloudHSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudHsmFrontendService.DescribeLunaClient");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLunaClientOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLunaClientOutput, body, allocator);
}
