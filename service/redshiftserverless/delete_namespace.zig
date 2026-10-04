const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Namespace = @import("namespace.zig").Namespace;

pub const DeleteNamespaceInput = struct {
    /// The name of the snapshot to be created before the namespace is deleted.
    final_snapshot_name: ?[]const u8 = null,

    /// How long to retain the final snapshot.
    final_snapshot_retention_period: ?i32 = null,

    /// The name of the namespace to delete.
    namespace_name: []const u8,

    pub const json_field_names = .{
        .final_snapshot_name = "finalSnapshotName",
        .final_snapshot_retention_period = "finalSnapshotRetentionPeriod",
        .namespace_name = "namespaceName",
    };
};

pub const DeleteNamespaceOutput = struct {
    /// The deleted namespace object.
    namespace: ?Namespace = null,

    pub const json_field_names = .{
        .namespace = "namespace",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteNamespaceInput, options: CallOptions) !DeleteNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.DeleteNamespace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteNamespaceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteNamespaceOutput, body, allocator);
}
