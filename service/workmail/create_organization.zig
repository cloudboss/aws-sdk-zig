const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Domain = @import("domain.zig").Domain;

pub const CreateOrganizationInput = struct {
    /// The organization alias.
    alias: []const u8,

    /// The idempotency token associated with the request.
    client_token: ?[]const u8 = null,

    /// The AWS Directory Service directory ID.
    directory_id: ?[]const u8 = null,

    /// The email domains to associate with the organization.
    domains: ?[]const Domain = null,

    /// When `true`, allows organization interoperability between WorkMail and
    /// Microsoft Exchange. If `true`, you must include a AD Connector directory ID
    /// in
    /// the request.
    enable_interoperability: ?bool = null,

    /// The Amazon Resource Name (ARN) of a customer managed key from AWS KMS.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .client_token = "ClientToken",
        .directory_id = "DirectoryId",
        .domains = "Domains",
        .enable_interoperability = "EnableInteroperability",
        .kms_key_arn = "KmsKeyArn",
    };
};

pub const CreateOrganizationOutput = struct {
    /// The organization ID.
    organization_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .organization_id = "OrganizationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOrganizationInput, options: CallOptions) !CreateOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.CreateOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateOrganizationOutput, body, allocator);
}
