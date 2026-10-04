const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorType = @import("connector_type.zig").ConnectorType;
const Connector = @import("connector.zig").Connector;

pub const CreateEnvironmentConnectorInput = struct {
    /// The fully qualified domain name (FQDN) of the VCF appliance that the
    /// connector targets.
    appliance_fqdn: []const u8,

    /// This parameter is not used in Amazon EVS currently. If you supply input for
    /// this parameter, it will have no effect.
    ///
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the connector creation request. If you do not specify a
    /// client token, a randomly generated token is used for the request to ensure
    /// idempotency.
    client_token: ?[]const u8 = null,

    /// A unique ID for the environment to create the connector in.
    environment_id: []const u8,

    /// The ARN or name of the Amazon Web Services Secrets Manager secret that
    /// stores the credentials for the VCF appliance.
    ///
    /// Do not use credentials with Administrator privileges. We recommend using a
    /// service account with the minimum required permissions.
    secret_identifier: []const u8,

    /// The type of connector to create.
    @"type": ConnectorType,

    pub const json_field_names = .{
        .appliance_fqdn = "applianceFqdn",
        .client_token = "clientToken",
        .environment_id = "environmentId",
        .secret_identifier = "secretIdentifier",
        .@"type" = "type",
    };
};

pub const CreateEnvironmentConnectorOutput = struct {
    /// A description of the created connector.
    connector: ?Connector = null,

    pub const json_field_names = .{
        .connector = "connector",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentConnectorInput, options: CallOptions) !CreateEnvironmentConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "evs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evs", "evs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonElasticVMwareService.CreateEnvironmentConnector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentConnectorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEnvironmentConnectorOutput, body, allocator);
}
