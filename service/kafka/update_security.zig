const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClientAuthentication = @import("client_authentication.zig").ClientAuthentication;
const EncryptionInfo = @import("encryption_info.zig").EncryptionInfo;

pub const UpdateSecurityInput = struct {
    /// Includes all client authentication related information.
    client_authentication: ?ClientAuthentication = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: []const u8,

    /// The version of the MSK cluster to update. Cluster versions aren't simple
    /// numbers. You can describe an MSK cluster to find its version. When this
    /// update operation is successful, it generates a new cluster version.
    current_version: []const u8,

    /// Includes all encryption-related information.
    encryption_info: ?EncryptionInfo = null,

    pub const json_field_names = .{
        .client_authentication = "ClientAuthentication",
        .cluster_arn = "ClusterArn",
        .current_version = "CurrentVersion",
        .encryption_info = "EncryptionInfo",
    };
};

pub const UpdateSecurityOutput = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the cluster operation.
    cluster_operation_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_operation_arn = "ClusterOperationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSecurityInput, options: CallOptions) !UpdateSecurityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSecurityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_arn);
    try path_buf.appendSlice(allocator, "/security");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_authentication) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientAuthentication\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CurrentVersion\":");
    try aws.json.writeValue(@TypeOf(input.current_version), input.current_version, allocator, &body_buf);
    has_prev = true;
    if (input.encryption_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSecurityOutput {
    var result: UpdateSecurityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSecurityOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
