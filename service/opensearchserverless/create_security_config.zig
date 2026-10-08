const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IamFederationConfigOptions = @import("iam_federation_config_options.zig").IamFederationConfigOptions;
const CreateIamIdentityCenterConfigOptions = @import("create_iam_identity_center_config_options.zig").CreateIamIdentityCenterConfigOptions;
const SamlConfigOptions = @import("saml_config_options.zig").SamlConfigOptions;
const SecurityConfigType = @import("security_config_type.zig").SecurityConfigType;
const SecurityConfigDetail = @import("security_config_detail.zig").SecurityConfigDetail;

pub const CreateSecurityConfigInput = struct {
    /// Unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// A description of the security configuration.
    description: ?[]const u8 = null,

    /// Describes IAM federation options in the form of a key-value map. This field
    /// is required if you specify `iamFederation` for the `type` parameter.
    iam_federation_options: ?IamFederationConfigOptions = null,

    /// Describes IAM Identity Center options in the form of a key-value map. This
    /// field is required if you specify `iamidentitycenter` for the `type`
    /// parameter.
    iam_identity_center_options: ?CreateIamIdentityCenterConfigOptions = null,

    /// The name of the security configuration.
    name: []const u8,

    /// Describes SAML options in the form of a key-value map. This field is
    /// required if you specify `SAML` for the `type` parameter.
    saml_options: ?SamlConfigOptions = null,

    /// The type of security configuration.
    type: SecurityConfigType,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .iam_federation_options = "iamFederationOptions",
        .iam_identity_center_options = "iamIdentityCenterOptions",
        .name = "name",
        .saml_options = "samlOptions",
        .type = "type",
    };
};

pub const CreateSecurityConfigOutput = struct {
    /// Details about the created security configuration.
    security_config_detail: ?SecurityConfigDetail = null,

    pub const json_field_names = .{
        .security_config_detail = "securityConfigDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSecurityConfigInput, options: CallOptions) !CreateSecurityConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aoss", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSecurityConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aoss", "OpenSearchServerless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.CreateSecurityConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSecurityConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSecurityConfigOutput, body, allocator);
}
