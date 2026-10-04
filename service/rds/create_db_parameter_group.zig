const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DBParameterGroup = @import("db_parameter_group.zig").DBParameterGroup;
const serde = @import("serde.zig");

pub const CreateDBParameterGroupInput = struct {
    /// The DB parameter group family name. A DB parameter group can be associated
    /// with one and only one DB parameter group family, and can be applied only to
    /// a DB instance running a database engine and engine version compatible with
    /// that DB parameter group family.
    ///
    /// To list all of the available parameter group families for a DB engine, use
    /// the following command:
    ///
    /// `aws rds describe-db-engine-versions --query
    /// "DBEngineVersions[].DBParameterGroupFamily" --engine <engine>`
    ///
    /// For example, to list all of the available parameter group families for the
    /// MySQL DB engine, use the following command:
    ///
    /// `aws rds describe-db-engine-versions --query
    /// "DBEngineVersions[].DBParameterGroupFamily" --engine mysql`
    ///
    /// The output contains duplicates.
    ///
    /// The following are the valid DB engine values:
    ///
    /// * `aurora-mysql`
    /// * `aurora-postgresql`
    /// * `db2-ae`
    /// * `db2-se`
    /// * `mysql`
    /// * `oracle-ee`
    /// * `oracle-ee-cdb`
    /// * `oracle-se2`
    /// * `oracle-se2-cdb`
    /// * `postgres`
    /// * `sqlserver-ee`
    /// * `sqlserver-se`
    /// * `sqlserver-ex`
    /// * `sqlserver-web`
    db_parameter_group_family: []const u8,

    /// The name of the DB parameter group.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 letters, numbers, or hyphens.
    /// * First character must be a letter
    /// * Can't end with a hyphen or contain two consecutive hyphens
    ///
    /// This value is stored as a lowercase string.
    db_parameter_group_name: []const u8,

    /// The description for the DB parameter group.
    description: []const u8,

    /// Tags to assign to the DB parameter group.
    tags: ?[]const Tag = null,
};

pub const CreateDBParameterGroupOutput = struct {
    db_parameter_group: ?DBParameterGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBParameterGroupInput, options: CallOptions) !CreateDBParameterGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateDBParameterGroup&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBParameterGroupFamily=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_parameter_group_family);
    try body_buf.appendSlice(allocator, "&DBParameterGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_parameter_group_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBParameterGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBParameterGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBParameterGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBParameterGroup")) {
                    result.db_parameter_group = try serde.deserializeDBParameterGroup(allocator, &reader);
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
