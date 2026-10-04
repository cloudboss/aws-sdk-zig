const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrustStoreResponseOption = @import("trust_store_response_option.zig").TrustStoreResponseOption;
const IngressPointAuthConfiguration = @import("ingress_point_auth_configuration.zig").IngressPointAuthConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const IngressPointStatus = @import("ingress_point_status.zig").IngressPointStatus;
const TlsPolicy = @import("tls_policy.zig").TlsPolicy;
const IngressPointType = @import("ingress_point_type.zig").IngressPointType;

pub const GetIngressPointInput = struct {
    /// Whether to include the trust store contents in the response. Use INCLUDE to
    /// retrieve trust store certificate and CRL contents.
    include_trust_store_contents: ?TrustStoreResponseOption = null,

    /// The identifier of an ingress endpoint.
    ingress_point_id: []const u8,

    pub const json_field_names = .{
        .include_trust_store_contents = "IncludeTrustStoreContents",
        .ingress_point_id = "IngressPointId",
    };
};

pub const GetIngressPointOutput = struct {
    /// The DNS A Record that identifies your ingress endpoint. Configure your DNS
    /// Mail Exchange (MX) record with this value to route emails to Mail Manager.
    a_record: ?[]const u8 = null,

    /// The timestamp of when the ingress endpoint was created.
    created_timestamp: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the ingress endpoint resource.
    ingress_point_arn: ?[]const u8 = null,

    /// The authentication configuration of the ingress endpoint resource.
    ingress_point_auth_configuration: ?IngressPointAuthConfiguration = null,

    /// The identifier of an ingress endpoint resource.
    ingress_point_id: []const u8,

    /// A user friendly name for the ingress endpoint.
    ingress_point_name: []const u8,

    /// The timestamp of when the ingress endpoint was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The network configuration for the ingress point.
    network_configuration: ?NetworkConfiguration = null,

    /// The identifier of a rule set resource associated with the ingress endpoint.
    rule_set_id: ?[]const u8 = null,

    /// The status of the ingress endpoint resource.
    status: ?IngressPointStatus = null,

    /// The selected Transport Layer Security (TLS) policy of the ingress point.
    tls_policy: ?TlsPolicy = null,

    /// The identifier of the traffic policy resource associated with the ingress
    /// endpoint.
    traffic_policy_id: ?[]const u8 = null,

    /// The type of ingress endpoint.
    @"type": ?IngressPointType = null,

    pub const json_field_names = .{
        .a_record = "ARecord",
        .created_timestamp = "CreatedTimestamp",
        .ingress_point_arn = "IngressPointArn",
        .ingress_point_auth_configuration = "IngressPointAuthConfiguration",
        .ingress_point_id = "IngressPointId",
        .ingress_point_name = "IngressPointName",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .network_configuration = "NetworkConfiguration",
        .rule_set_id = "RuleSetId",
        .status = "Status",
        .tls_policy = "TlsPolicy",
        .traffic_policy_id = "TrafficPolicyId",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIngressPointInput, options: CallOptions) !GetIngressPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIngressPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetIngressPoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIngressPointOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetIngressPointOutput, body, allocator);
}
