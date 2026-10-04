const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateSubjectType = @import("certificate_subject_type.zig").CertificateSubjectType;
const SigningAlgorithmType = @import("signing_algorithm_type.zig").SigningAlgorithmType;

pub const GetCertificateSigningRequestInput = struct {
    /// The metadata used to create the CSR.
    certificate_subject: CertificateSubjectType,

    /// Asymmetric key used for generating the certificate signing request
    key_identifier: []const u8,

    /// The cryptographic algorithm used to sign your CSR.
    signing_algorithm: SigningAlgorithmType,

    pub const json_field_names = .{
        .certificate_subject = "CertificateSubject",
        .key_identifier = "KeyIdentifier",
        .signing_algorithm = "SigningAlgorithm",
    };
};

pub const GetCertificateSigningRequestOutput = struct {
    /// The certificate signing request generated using the key pair associated with
    /// the key identifier.
    certificate_signing_request: []const u8,

    pub const json_field_names = .{
        .certificate_signing_request = "CertificateSigningRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCertificateSigningRequestInput, options: CallOptions) !GetCertificateSigningRequestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "payment-cryptography", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCertificateSigningRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controlplane.payment-cryptography", "Payment Cryptography", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.GetCertificateSigningRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCertificateSigningRequestOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetCertificateSigningRequestOutput, body, allocator);
}
