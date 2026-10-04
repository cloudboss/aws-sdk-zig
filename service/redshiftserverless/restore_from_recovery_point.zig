const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Namespace = @import("namespace.zig").Namespace;

pub const RestoreFromRecoveryPointInput = struct {
    /// If `true`, maintain existing data sharing, zero-ETL and S3 event
    /// integrations when restoring. Otherwise, integrations will not be maintained
    /// after the restore operation. Integrations are only maintained when restored
    /// to the same serverless namespace.
    ///
    /// Default: true
    maintain_integration: ?bool = null,

    /// The name of the namespace to restore data into.
    namespace_name: []const u8,

    /// The unique identifier of the recovery point to restore from.
    recovery_point_id: []const u8,

    /// The name of the workgroup used to restore data.
    workgroup_name: []const u8,

    pub const json_field_names = .{
        .maintain_integration = "maintainIntegration",
        .namespace_name = "namespaceName",
        .recovery_point_id = "recoveryPointId",
        .workgroup_name = "workgroupName",
    };
};

pub const RestoreFromRecoveryPointOutput = struct {
    /// The namespace that data was restored into.
    namespace: ?Namespace = null,

    /// The unique identifier of the recovery point used for the restore.
    recovery_point_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .namespace = "namespace",
        .recovery_point_id = "recoveryPointId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreFromRecoveryPointInput, options: CallOptions) !RestoreFromRecoveryPointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreFromRecoveryPointInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.RestoreFromRecoveryPoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreFromRecoveryPointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RestoreFromRecoveryPointOutput, body, allocator);
}
