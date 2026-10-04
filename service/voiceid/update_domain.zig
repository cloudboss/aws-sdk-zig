const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const Domain = @import("domain.zig").Domain;

pub const UpdateDomainInput = struct {
    /// A brief description about this domain.
    description: ?[]const u8 = null,

    /// The identifier of the domain to be updated.
    domain_id: []const u8,

    /// The name of the domain.
    name: []const u8,

    /// The configuration, containing the KMS key identifier, to be used by
    /// Voice ID for the server-side encryption of your data. Changing the domain's
    /// associated
    /// KMS key immediately triggers an asynchronous process to remove
    /// dependency on the old KMS key, such that the domain's data can only be
    /// accessed using the new KMS key. The domain's
    /// `ServerSideEncryptionUpdateDetails` contains the details for this
    /// process.
    server_side_encryption_configuration: ServerSideEncryptionConfiguration,

    pub const json_field_names = .{
        .description = "Description",
        .domain_id = "DomainId",
        .name = "Name",
        .server_side_encryption_configuration = "ServerSideEncryptionConfiguration",
    };
};

pub const UpdateDomainOutput = struct {
    /// Details about the updated domain
    domain: ?Domain = null,

    pub const json_field_names = .{
        .domain = "Domain",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainInput, options: CallOptions) !UpdateDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDomainInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "VoiceID.UpdateDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDomainOutput, body, allocator);
}
