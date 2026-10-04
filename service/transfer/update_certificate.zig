const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateCertificateInput = struct {
    /// An optional date that specifies when the certificate becomes active. If you
    /// do not specify a value, `ActiveDate` takes the same value as
    /// `NotBeforeDate`, which is specified by the CA.
    active_date: ?i64 = null,

    /// The identifier of the certificate object that you are updating.
    certificate_id: []const u8,

    /// A short description to help identify the certificate.
    description: ?[]const u8 = null,

    /// An optional date that specifies when the certificate becomes inactive. If
    /// you do not specify a value, `InactiveDate` takes the same value as
    /// `NotAfterDate`, which is specified by the CA.
    inactive_date: ?i64 = null,

    pub const json_field_names = .{
        .active_date = "ActiveDate",
        .certificate_id = "CertificateId",
        .description = "Description",
        .inactive_date = "InactiveDate",
    };
};

pub const UpdateCertificateOutput = struct {
    /// Returns the identifier of the certificate object that you are updating.
    certificate_id: []const u8,

    pub const json_field_names = .{
        .certificate_id = "CertificateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCertificateInput, options: CallOptions) !UpdateCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.UpdateCertificate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCertificateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateCertificateOutput, body, allocator);
}
