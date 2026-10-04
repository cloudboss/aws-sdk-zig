const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngressPointConfiguration = @import("ingress_point_configuration.zig").IngressPointConfiguration;
const IngressPointStatusToUpdate = @import("ingress_point_status_to_update.zig").IngressPointStatusToUpdate;
const TlsPolicy = @import("tls_policy.zig").TlsPolicy;

pub const UpdateIngressPointInput = struct {
    /// If you choose an Authenticated ingress endpoint, you must configure either
    /// an SMTP password or a secret ARN.
    ingress_point_configuration: ?IngressPointConfiguration = null,

    /// The identifier for the ingress endpoint you want to update.
    ingress_point_id: []const u8,

    /// A user friendly name for the ingress endpoint resource.
    ingress_point_name: ?[]const u8 = null,

    /// The identifier of an existing rule set that you attach to an ingress
    /// endpoint resource.
    rule_set_id: ?[]const u8 = null,

    /// The update status of an ingress endpoint.
    status_to_update: ?IngressPointStatusToUpdate = null,

    /// The Transport Layer Security (TLS) policy for the ingress point. Valid
    /// values are REQUIRED, OPTIONAL. Only ingress endpoints using REQUIRED or
    /// OPTIONAL as TlsPolicy can be updated.
    tls_policy: ?TlsPolicy = null,

    /// The identifier of an existing traffic policy that you attach to an ingress
    /// endpoint resource.
    traffic_policy_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ingress_point_configuration = "IngressPointConfiguration",
        .ingress_point_id = "IngressPointId",
        .ingress_point_name = "IngressPointName",
        .rule_set_id = "RuleSetId",
        .status_to_update = "StatusToUpdate",
        .tls_policy = "TlsPolicy",
        .traffic_policy_id = "TrafficPolicyId",
    };
};

pub const UpdateIngressPointOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIngressPointInput, options: CallOptions) !UpdateIngressPointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIngressPointInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.UpdateIngressPoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIngressPointOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
