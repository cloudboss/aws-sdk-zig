const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Namespace = @import("namespace.zig").Namespace;

pub const RestoreFromSnapshotInput = struct {
    /// The ID of the Key Management Service (KMS) key used to encrypt and store the
    /// namespace's admin credentials secret.
    admin_password_secret_kms_key_id: ?[]const u8 = null,

    /// If `true`, Amazon Redshift uses Secrets Manager to manage the restored
    /// snapshot's admin credentials. If `MmanageAdminPassword` is false or not set,
    /// Amazon Redshift uses the admin credentials that the namespace or cluster had
    /// at the time the snapshot was taken.
    manage_admin_password: ?bool = null,

    /// The name of the namespace to restore the snapshot to.
    namespace_name: []const u8,

    /// The Amazon Web Services account that owns the snapshot.
    owner_account: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the snapshot to restore from. Required if
    /// restoring from a provisioned cluster to Amazon Redshift Serverless. Must not
    /// be specified at the same time as `snapshotName`.
    ///
    /// The format of the ARN is
    /// arn:aws:redshift:<region>:<account_id>:snapshot:<cluster_identifier>/<snapshot_identifier>.
    snapshot_arn: ?[]const u8 = null,

    /// The name of the snapshot to restore from. Must not be specified at the same
    /// time as `snapshotArn`.
    snapshot_name: ?[]const u8 = null,

    /// The name of the workgroup used to restore the snapshot.
    workgroup_name: []const u8,

    pub const json_field_names = .{
        .admin_password_secret_kms_key_id = "adminPasswordSecretKmsKeyId",
        .manage_admin_password = "manageAdminPassword",
        .namespace_name = "namespaceName",
        .owner_account = "ownerAccount",
        .snapshot_arn = "snapshotArn",
        .snapshot_name = "snapshotName",
        .workgroup_name = "workgroupName",
    };
};

pub const RestoreFromSnapshotOutput = struct {
    namespace: ?Namespace = null,

    /// The owner Amazon Web Services; account of the snapshot that was restored.
    owner_account: ?[]const u8 = null,

    /// The name of the snapshot used to restore the namespace.
    snapshot_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .namespace = "namespace",
        .owner_account = "ownerAccount",
        .snapshot_name = "snapshotName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreFromSnapshotInput, options: CallOptions) !RestoreFromSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreFromSnapshotInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.RestoreFromSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreFromSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RestoreFromSnapshotOutput, body, allocator);
}
