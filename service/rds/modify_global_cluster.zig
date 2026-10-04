const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalCluster = @import("global_cluster.zig").GlobalCluster;
const serde = @import("serde.zig");

pub const ModifyGlobalClusterInput = struct {
    /// Specifies whether to allow major version upgrades.
    ///
    /// Constraints: Must be enabled if you specify a value for the `EngineVersion`
    /// parameter that's a different major version than the global cluster's current
    /// version.
    ///
    /// If you upgrade the major version of a global database, the cluster and DB
    /// instance parameter groups are set to the default parameter groups for the
    /// new version. Apply any custom parameter groups after completing the upgrade.
    allow_major_version_upgrade: ?bool = null,

    /// Specifies whether to enable deletion protection for the global database
    /// cluster. The global database cluster can't be deleted when deletion
    /// protection is enabled.
    deletion_protection: ?bool = null,

    /// The version number of the database engine to which you want to upgrade.
    ///
    /// To list all of the available engine versions for `aurora-mysql` (for
    /// MySQL-based Aurora global databases), use the following command:
    ///
    /// `aws rds describe-db-engine-versions --engine aurora-mysql --query
    /// '*[]|[?SupportsGlobalDatabases == `true`].[EngineVersion]'`
    ///
    /// To list all of the available engine versions for `aurora-postgresql` (for
    /// PostgreSQL-based Aurora global databases), use the following command:
    ///
    /// `aws rds describe-db-engine-versions --engine aurora-postgresql --query
    /// '*[]|[?SupportsGlobalDatabases == `true`].[EngineVersion]'`
    engine_version: ?[]const u8 = null,

    /// The cluster identifier for the global cluster to modify. This parameter
    /// isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing global database cluster.
    global_cluster_identifier: []const u8,

    /// The new cluster identifier for the global database cluster. This value is
    /// stored as a lowercase string.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    /// * The first character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `my-cluster2`
    new_global_cluster_identifier: ?[]const u8 = null,
};

pub const ModifyGlobalClusterOutput = struct {
    global_cluster: ?GlobalCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyGlobalClusterInput, options: CallOptions) !ModifyGlobalClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyGlobalClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyGlobalCluster&Version=2014-10-31");
    if (input.allow_major_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AllowMajorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.deletion_protection) |v| {
        try body_buf.appendSlice(allocator, "&DeletionProtection=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&GlobalClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.global_cluster_identifier);
    if (input.new_global_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&NewGlobalClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyGlobalClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyGlobalClusterResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyGlobalClusterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GlobalCluster")) {
                    result.global_cluster = try serde.deserializeGlobalCluster(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
