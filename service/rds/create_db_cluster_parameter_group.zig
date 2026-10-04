const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DBClusterParameterGroup = @import("db_cluster_parameter_group.zig").DBClusterParameterGroup;
const serde = @import("serde.zig");

pub const CreateDBClusterParameterGroupInput = struct {
    /// The name of the DB cluster parameter group.
    ///
    /// Constraints:
    ///
    /// * Must not match the name of an existing DB cluster parameter group.
    ///
    /// This value is stored as a lowercase string.
    db_cluster_parameter_group_name: []const u8,

    /// The DB cluster parameter group family name. A DB cluster parameter group can
    /// be associated with one and only one DB cluster parameter group family, and
    /// can be applied only to a DB cluster running a database engine and engine
    /// version compatible with that DB cluster parameter group family.
    ///
    /// **Aurora MySQL**
    ///
    /// Example: `aurora-mysql5.7`, `aurora-mysql8.0`
    ///
    /// **Aurora PostgreSQL**
    ///
    /// Example: `aurora-postgresql14`
    ///
    /// **RDS for MySQL**
    ///
    /// Example: `mysql8.0`
    ///
    /// **RDS for PostgreSQL**
    ///
    /// Example: `postgres13`
    ///
    /// To list all of the available parameter group families for a DB engine, use
    /// the following command:
    ///
    /// `aws rds describe-db-engine-versions --query
    /// "DBEngineVersions[].DBParameterGroupFamily" --engine <engine>`
    ///
    /// For example, to list all of the available parameter group families for the
    /// Aurora PostgreSQL DB engine, use the following command:
    ///
    /// `aws rds describe-db-engine-versions --query
    /// "DBEngineVersions[].DBParameterGroupFamily" --engine aurora-postgresql`
    ///
    /// The output contains duplicates.
    ///
    /// The following are the valid DB engine values:
    ///
    /// * `aurora-mysql`
    /// * `aurora-postgresql`
    /// * `mysql`
    /// * `postgres`
    db_parameter_group_family: []const u8,

    /// The description for the DB cluster parameter group.
    description: []const u8,

    /// Tags to assign to the DB cluster parameter group.
    tags: ?[]const Tag = null,
};

pub const CreateDBClusterParameterGroupOutput = struct {
    db_cluster_parameter_group: ?DBClusterParameterGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBClusterParameterGroupInput, options: CallOptions) !CreateDBClusterParameterGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBClusterParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateDBClusterParameterGroup&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBClusterParameterGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_parameter_group_name);
    try body_buf.appendSlice(allocator, "&DBParameterGroupFamily=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_parameter_group_family);
    try body_buf.appendSlice(allocator, "&Description=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.description);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBClusterParameterGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBClusterParameterGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBClusterParameterGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterParameterGroup")) {
                    result.db_cluster_parameter_group = try serde.deserializeDBClusterParameterGroup(allocator, &reader);
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
