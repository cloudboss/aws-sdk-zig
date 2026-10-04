const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const GlobalCluster = @import("global_cluster.zig").GlobalCluster;
const serde = @import("serde.zig");

pub const CreateGlobalClusterInput = struct {
    /// The name for your database of up to 64 alphanumeric characters. If you don't
    /// specify a name, Amazon Aurora doesn't create a database in the global
    /// database cluster.
    ///
    /// Constraints:
    ///
    /// * Can't be specified if `SourceDBClusterIdentifier` is specified. In this
    ///   case, Amazon Aurora uses the database name from the source DB cluster.
    database_name: ?[]const u8 = null,

    /// Specifies whether to enable deletion protection for the new global database
    /// cluster. The global database can't be deleted when deletion protection is
    /// enabled.
    deletion_protection: ?bool = null,

    /// The database engine to use for this global database cluster.
    ///
    /// Valid Values: `aurora-mysql | aurora-postgresql`
    ///
    /// Constraints:
    ///
    /// * Can't be specified if `SourceDBClusterIdentifier` is specified. In this
    ///   case, Amazon Aurora uses the engine of the source DB cluster.
    engine: ?[]const u8 = null,

    /// The lifecycle type for this global database cluster.
    ///
    /// By default, this value is set to `open-source-rds-extended-support`, which
    /// enrolls your global cluster into Amazon RDS Extended Support. At the end of
    /// standard support, you can avoid charges for Extended Support by setting the
    /// value to `open-source-rds-extended-support-disabled`. In this case, creating
    /// the global cluster will fail if the DB major version is past its end of
    /// standard support date.
    ///
    /// This setting only applies to Aurora PostgreSQL-based global databases.
    ///
    /// You can use this setting to enroll your global cluster into Amazon RDS
    /// Extended Support. With RDS Extended Support, you can run the selected major
    /// engine version on your global cluster past the end of standard support for
    /// that engine version. For more information, see [Amazon RDS Extended Support
    /// with Amazon
    /// Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/extended-support.html) in the *Amazon Aurora User Guide*.
    ///
    /// Valid Values: `open-source-rds-extended-support |
    /// open-source-rds-extended-support-disabled`
    ///
    /// Default: `open-source-rds-extended-support`
    engine_lifecycle_support: ?[]const u8 = null,

    /// The engine version to use for this global database cluster.
    ///
    /// Constraints:
    ///
    /// * Can't be specified if `SourceDBClusterIdentifier` is specified. In this
    ///   case, Amazon Aurora uses the engine version of the source DB cluster.
    engine_version: ?[]const u8 = null,

    /// The cluster identifier for this global database cluster. This parameter is
    /// stored as a lowercase string.
    global_cluster_identifier: []const u8,

    /// The Amazon Resource Name (ARN) to use as the primary cluster of the global
    /// database.
    ///
    /// If you provide a value for this parameter, don't specify values for the
    /// following settings because Amazon Aurora uses the values from the specified
    /// source DB cluster:
    ///
    /// * `DatabaseName`
    /// * `Engine`
    /// * `EngineVersion`
    /// * `StorageEncrypted`
    source_db_cluster_identifier: ?[]const u8 = null,

    /// Specifies whether to enable storage encryption for the new global database
    /// cluster.
    ///
    /// Constraints:
    ///
    /// * Can't be specified if `SourceDBClusterIdentifier` is specified. In this
    ///   case, Amazon Aurora uses the setting from the source DB cluster.
    storage_encrypted: ?bool = null,

    /// Tags to assign to the global cluster.
    tags: ?[]const Tag = null,
};

pub const CreateGlobalClusterOutput = struct {
    global_cluster: ?GlobalCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGlobalClusterInput, options: CallOptions) !CreateGlobalClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGlobalClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateGlobalCluster&Version=2014-10-31");
    if (input.database_name) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.deletion_protection) |v| {
        try body_buf.appendSlice(allocator, "&DeletionProtection=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_lifecycle_support) |v| {
        try body_buf.appendSlice(allocator, "&EngineLifecycleSupport=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&GlobalClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.global_cluster_identifier);
    if (input.source_db_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SourceDBClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.storage_encrypted) |v| {
        try body_buf.appendSlice(allocator, "&StorageEncrypted=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGlobalClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateGlobalClusterResult")) break;
            },
            else => {},
        }
    }

    var result: CreateGlobalClusterOutput = .{};
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
