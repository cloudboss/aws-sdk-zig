const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotCopyConfiguration = @import("snapshot_copy_configuration.zig").SnapshotCopyConfiguration;

pub const CreateSnapshotCopyConfigurationInput = struct {
    /// The KMS key to use to encrypt your snapshots in the destination Amazon Web
    /// Services Region.
    destination_kms_key_id: ?[]const u8 = null,

    /// The destination Amazon Web Services Region that you want to copy snapshots
    /// to.
    destination_region: []const u8,

    /// The name of the namespace to copy snapshots from.
    namespace_name: []const u8,

    /// The retention period of the snapshots that you copy to the destination
    /// Amazon Web Services Region.
    snapshot_retention_period: ?i32 = null,

    pub const json_field_names = .{
        .destination_kms_key_id = "destinationKmsKeyId",
        .destination_region = "destinationRegion",
        .namespace_name = "namespaceName",
        .snapshot_retention_period = "snapshotRetentionPeriod",
    };
};

pub const CreateSnapshotCopyConfigurationOutput = struct {
    /// The snapshot copy configuration object that is returned.
    snapshot_copy_configuration: ?SnapshotCopyConfiguration = null,

    pub const json_field_names = .{
        .snapshot_copy_configuration = "snapshotCopyConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSnapshotCopyConfigurationInput, options: CallOptions) !CreateSnapshotCopyConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSnapshotCopyConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.CreateSnapshotCopyConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSnapshotCopyConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateSnapshotCopyConfigurationOutput, body, allocator);
}
