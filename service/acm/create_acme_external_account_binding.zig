const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Expiration = @import("expiration.zig").Expiration;
const Tag = @import("tag.zig").Tag;
const AcmeExternalAccountBinding = @import("acme_external_account_binding.zig").AcmeExternalAccountBinding;

pub const CreateAcmeExternalAccountBindingInput = struct {
    /// The Amazon Resource Name (ARN) of the ACME endpoint.
    acme_endpoint_arn: []const u8,

    /// The expiration configuration for the external account binding.
    expiration: ?Expiration = null,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    idempotency_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role to associate with the
    /// external account binding.
    role_arn: []const u8,

    /// One or more tags to associate with the external account binding.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .acme_endpoint_arn = "AcmeEndpointArn",
        .expiration = "Expiration",
        .idempotency_token = "IdempotencyToken",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateAcmeExternalAccountBindingOutput = struct {
    /// The created external account binding.
    external_account_binding: ?AcmeExternalAccountBinding = null,

    pub const json_field_names = .{
        .external_account_binding = "ExternalAccountBinding",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAcmeExternalAccountBindingInput, options: CallOptions) !CreateAcmeExternalAccountBindingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAcmeExternalAccountBindingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.CreateAcmeExternalAccountBinding");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAcmeExternalAccountBindingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAcmeExternalAccountBindingOutput, body, allocator);
}
