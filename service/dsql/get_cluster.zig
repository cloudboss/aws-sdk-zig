const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionDetails = @import("encryption_details.zig").EncryptionDetails;
const MultiRegionProperties = @import("multi_region_properties.zig").MultiRegionProperties;
const ClusterStatus = @import("cluster_status.zig").ClusterStatus;

pub const GetClusterInput = struct {
    /// The ID of the cluster to retrieve.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub const GetClusterOutput = struct {
    /// The ARN of the retrieved cluster.
    arn: []const u8,

    /// The time of when the cluster was created.
    creation_time: i64,

    /// Whether deletion protection is enabled in this cluster.
    deletion_protection_enabled: bool,

    /// The current encryption configuration details for the cluster.
    encryption_details: ?EncryptionDetails = null,

    /// The connection endpoint for the cluster.
    endpoint: ?[]const u8 = null,

    /// The ID of the retrieved cluster.
    identifier: []const u8,

    /// Returns the current multi-Region cluster configuration, including witness
    /// region and linked cluster information.
    multi_region_properties: ?MultiRegionProperties = null,

    /// The status of the retrieved cluster.
    status: ClusterStatus,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .encryption_details = "encryptionDetails",
        .endpoint = "endpoint",
        .identifier = "identifier",
        .multi_region_properties = "multiRegionProperties",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetClusterInput, options: CallOptions) !GetClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dsql", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dsql", "DSQL", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/cluster/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetClusterOutput {
    const result: GetClusterOutput = try aws.json.parseJsonObject(
        GetClusterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
