const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const Tag = @import("tag.zig").Tag;
const Domain = @import("domain.zig").Domain;

pub const CreateDomainInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// A brief description of this domain.
    description: ?[]const u8 = null,

    /// The name of the domain.
    name: []const u8,

    /// The configuration, containing the KMS key identifier, to be used by
    /// Voice ID for the server-side encryption of your data. Refer to [
    /// Amazon Connect Voice ID encryption at
    /// rest](https://docs.aws.amazon.com/connect/latest/adminguide/encryption-at-rest.html#encryption-at-rest-voiceid) for more details on how the KMS key is used.
    server_side_encryption_configuration: ServerSideEncryptionConfiguration,

    /// A list of tags you want added to the domain.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .server_side_encryption_configuration = "ServerSideEncryptionConfiguration",
        .tags = "Tags",
    };
};

pub const CreateDomainOutput = struct {
    /// Information about the newly created domain.
    domain: ?Domain = null,

    pub const json_field_names = .{
        .domain = "Domain",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainInput, options: CallOptions) !CreateDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "voiceid", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voiceid", "Voice ID", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VoiceID.CreateDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDomainOutput, body, allocator);
}
