const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotCopyConfiguration = @import("snapshot_copy_configuration.zig").SnapshotCopyConfiguration;

pub const UpdateSnapshotCopyConfigurationInput = struct {
    /// The ID of the snapshot copy configuration to update.
    snapshot_copy_configuration_id: []const u8,

    /// The new retention period of how long to keep a snapshot in the destination
    /// Amazon Web Services Region.
    snapshot_retention_period: ?i32 = null,

    pub const json_field_names = .{
        .snapshot_copy_configuration_id = "snapshotCopyConfigurationId",
        .snapshot_retention_period = "snapshotRetentionPeriod",
    };
};

pub const UpdateSnapshotCopyConfigurationOutput = struct {
    /// The updated snapshot copy configuration object.
    snapshot_copy_configuration: ?SnapshotCopyConfiguration = null,

    pub const json_field_names = .{
        .snapshot_copy_configuration = "snapshotCopyConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSnapshotCopyConfigurationInput, options: CallOptions) !UpdateSnapshotCopyConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSnapshotCopyConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.UpdateSnapshotCopyConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSnapshotCopyConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateSnapshotCopyConfigurationOutput, body, allocator);
}
