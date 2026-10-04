const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetBootstrapBrokersInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
    };
};

pub const GetBootstrapBrokersOutput = struct {
    /// A string containing one or more hostname:port pairs.
    bootstrap_broker_string: ?[]const u8 = null,

    /// A string that contains one or more DNS names (or IP) and port pairs for IPv6
    /// connectivity.
    bootstrap_broker_string_ipv_6: ?[]const u8 = null,

    /// A string that contains one or more DNS names (or IP addresses) and SASL IAM
    /// port pairs.
    bootstrap_broker_string_public_sasl_iam: ?[]const u8 = null,

    /// A string containing one or more DNS names (or IP) and Sasl Scram port pairs.
    bootstrap_broker_string_public_sasl_scram: ?[]const u8 = null,

    /// A string containing one or more DNS names (or IP) and TLS port pairs.
    bootstrap_broker_string_public_tls: ?[]const u8 = null,

    /// A string that contains one or more DNS names (or IP addresses) and SASL IAM
    /// port pairs.
    bootstrap_broker_string_sasl_iam: ?[]const u8 = null,

    /// A string that contains one or more DNS names (or IP) and SASL IAM port pairs
    /// for IPv6 connectivity.
    bootstrap_broker_string_sasl_iam_ipv_6: ?[]const u8 = null,

    /// A string containing one or more DNS names (or IP) and Sasl Scram port pairs.
    bootstrap_broker_string_sasl_scram: ?[]const u8 = null,

    /// A string that contains one or more DNS names (or IP) and SASL SCRAM port
    /// pairs for IPv6 connectivity.
    bootstrap_broker_string_sasl_scram_ipv_6: ?[]const u8 = null,

    /// A string containing one or more DNS names (or IP) and TLS port pairs.
    bootstrap_broker_string_tls: ?[]const u8 = null,

    /// A string that contains one or more DNS names (or IP) and TLS port pairs for
    /// IPv6 connectivity.
    bootstrap_broker_string_tls_ipv_6: ?[]const u8 = null,

    /// A string containing one or more DNS names (or IP) and SASL/IAM port pairs
    /// for VPC connectivity.
    bootstrap_broker_string_vpc_connectivity_sasl_iam: ?[]const u8 = null,

    /// A string containing one or more DNS names (or IP) and SASL/SCRAM port pairs
    /// for VPC connectivity.
    bootstrap_broker_string_vpc_connectivity_sasl_scram: ?[]const u8 = null,

    /// A string containing one or more DNS names (or IP) and TLS port pairs for VPC
    /// connectivity.
    bootstrap_broker_string_vpc_connectivity_tls: ?[]const u8 = null,

    pub const json_field_names = .{
        .bootstrap_broker_string = "BootstrapBrokerString",
        .bootstrap_broker_string_ipv_6 = "BootstrapBrokerStringIpv6",
        .bootstrap_broker_string_public_sasl_iam = "BootstrapBrokerStringPublicSaslIam",
        .bootstrap_broker_string_public_sasl_scram = "BootstrapBrokerStringPublicSaslScram",
        .bootstrap_broker_string_public_tls = "BootstrapBrokerStringPublicTls",
        .bootstrap_broker_string_sasl_iam = "BootstrapBrokerStringSaslIam",
        .bootstrap_broker_string_sasl_iam_ipv_6 = "BootstrapBrokerStringSaslIamIpv6",
        .bootstrap_broker_string_sasl_scram = "BootstrapBrokerStringSaslScram",
        .bootstrap_broker_string_sasl_scram_ipv_6 = "BootstrapBrokerStringSaslScramIpv6",
        .bootstrap_broker_string_tls = "BootstrapBrokerStringTls",
        .bootstrap_broker_string_tls_ipv_6 = "BootstrapBrokerStringTlsIpv6",
        .bootstrap_broker_string_vpc_connectivity_sasl_iam = "BootstrapBrokerStringVpcConnectivitySaslIam",
        .bootstrap_broker_string_vpc_connectivity_sasl_scram = "BootstrapBrokerStringVpcConnectivitySaslScram",
        .bootstrap_broker_string_vpc_connectivity_tls = "BootstrapBrokerStringVpcConnectivityTls",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBootstrapBrokersInput, options: CallOptions) !GetBootstrapBrokersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBootstrapBrokersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_arn);
    try path_buf.appendSlice(allocator, "/bootstrap-brokers");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBootstrapBrokersOutput {
    const result: GetBootstrapBrokersOutput = try aws.json.parseJsonObject(
        GetBootstrapBrokersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
