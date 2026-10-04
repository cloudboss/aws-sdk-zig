const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BaselineOverride = @import("baseline_override.zig").BaselineOverride;

pub const GetDeployablePatchSnapshotForInstanceInput = struct {
    /// Defines the basic information about a patch baseline override.
    baseline_override: ?BaselineOverride = null,

    /// The ID of the managed node for which the appropriate patch snapshot should
    /// be
    /// retrieved.
    instance_id: []const u8,

    /// The snapshot ID provided by the user when running `AWS-RunPatchBaseline`.
    snapshot_id: []const u8,

    /// Specifies whether to use S3 dualstack endpoints for the patch snapshot
    /// download URL. Set to
    /// `true` to receive a presigned URL that supports both IPv4 and IPv6
    /// connectivity. Set
    /// to `false` to use standard IPv4-only endpoints. Default is `false`. This
    /// parameter is required for managed nodes in IPv6-only environments.
    use_s3_dual_stack_endpoint: ?bool = null,

    pub const json_field_names = .{
        .baseline_override = "BaselineOverride",
        .instance_id = "InstanceId",
        .snapshot_id = "SnapshotId",
        .use_s3_dual_stack_endpoint = "UseS3DualStackEndpoint",
    };
};

pub const GetDeployablePatchSnapshotForInstanceOutput = struct {
    /// The managed node ID.
    instance_id: ?[]const u8 = null,

    /// Returns the specific operating system (for example Windows Server 2012 or
    /// Amazon Linux
    /// 2015.09) on the managed node for the specified patch snapshot.
    product: ?[]const u8 = null,

    /// A pre-signed Amazon Simple Storage Service (Amazon S3) URL that can be used
    /// to download the
    /// patch snapshot.
    snapshot_download_url: ?[]const u8 = null,

    /// The user-defined snapshot ID.
    snapshot_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .product = "Product",
        .snapshot_download_url = "SnapshotDownloadUrl",
        .snapshot_id = "SnapshotId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeployablePatchSnapshotForInstanceInput, options: CallOptions) !GetDeployablePatchSnapshotForInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeployablePatchSnapshotForInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetDeployablePatchSnapshotForInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeployablePatchSnapshotForInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDeployablePatchSnapshotForInstanceOutput, body, allocator);
}
