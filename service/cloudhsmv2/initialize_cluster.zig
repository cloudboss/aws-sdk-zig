const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterState = @import("cluster_state.zig").ClusterState;

pub const InitializeClusterInput = struct {
    /// The identifier (ID) of the cluster that you are claiming. To find the
    /// cluster ID, use
    /// DescribeClusters.
    cluster_id: []const u8,

    /// The cluster certificate issued (signed) by your issuing certificate
    /// authority (CA). The
    /// certificate must be in PEM format and can contain a maximum of 5000
    /// characters.
    signed_cert: []const u8,

    /// The issuing certificate of the issuing certificate authority (CA) that
    /// issued (signed)
    /// the cluster certificate. You must use a self-signed certificate. The
    /// certificate used to sign the HSM CSR must be directly available, and thus
    /// must be the
    /// root certificate. The certificate must be in PEM format and can contain a
    /// maximum of 5000 characters.
    trust_anchor: []const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .signed_cert = "SignedCert",
        .trust_anchor = "TrustAnchor",
    };
};

pub const InitializeClusterOutput = struct {
    /// The cluster's state.
    state: ?ClusterState = null,

    /// A description of the cluster's state.
    state_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .state = "State",
        .state_message = "StateMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InitializeClusterInput, options: CallOptions) !InitializeClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudhsm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InitializeClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsmv2", "CloudHSM V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "BaldrApiService.InitializeCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InitializeClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(InitializeClusterOutput, body, allocator);
}
