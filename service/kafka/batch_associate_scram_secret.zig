const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UnprocessedScramSecret = @import("unprocessed_scram_secret.zig").UnprocessedScramSecret;

pub const BatchAssociateScramSecretInput = struct {
    /// The Amazon Resource Name (ARN) of the cluster to be updated.
    cluster_arn: []const u8,

    /// List of AWS Secrets Manager secret ARNs.
    secret_arn_list: []const []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .secret_arn_list = "SecretArnList",
    };
};

pub const BatchAssociateScramSecretOutput = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// List of errors when associating secrets to cluster.
    unprocessed_scram_secrets: ?[]const UnprocessedScramSecret = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .unprocessed_scram_secrets = "UnprocessedScramSecrets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchAssociateScramSecretInput, options: CallOptions) !BatchAssociateScramSecretOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchAssociateScramSecretInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_arn);
    try path_buf.appendSlice(allocator, "/scram-secrets");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecretArnList\":");
    try aws.json.writeValue(@TypeOf(input.secret_arn_list), input.secret_arn_list, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchAssociateScramSecretOutput {
    var result: BatchAssociateScramSecretOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchAssociateScramSecretOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
