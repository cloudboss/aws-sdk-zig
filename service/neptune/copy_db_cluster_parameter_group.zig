const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DBClusterParameterGroup = @import("db_cluster_parameter_group.zig").DBClusterParameterGroup;
const serde = @import("serde.zig");

pub const CopyDBClusterParameterGroupInput = struct {
    /// The identifier or Amazon Resource Name (ARN) for the source DB cluster
    /// parameter group.
    /// For information about creating an ARN, see [ Constructing an
    /// Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/neptune/latest/UserGuide/tagging.ARN.html#tagging.ARN.Constructing).
    ///
    /// Constraints:
    ///
    /// * Must specify a valid DB cluster parameter group.
    ///
    /// * If the source DB cluster parameter group is in the same Amazon Region as
    ///   the copy,
    /// specify a valid DB parameter group identifier, for example
    /// `my-db-cluster-param-group`, or a valid ARN.
    ///
    /// * If the source DB parameter group is in a different Amazon Region than the
    ///   copy, specify a
    /// valid DB cluster parameter group ARN, for example
    /// `arn:aws:rds:us-east-1:123456789012:cluster-pg:custom-cluster-group1`.
    source_db_cluster_parameter_group_identifier: []const u8,

    /// The tags to be assigned to the copied DB cluster parameter group.
    tags: ?[]const Tag = null,

    /// A description for the copied DB cluster parameter group.
    target_db_cluster_parameter_group_description: []const u8,

    /// The identifier for the copied DB cluster parameter group.
    ///
    /// Constraints:
    ///
    /// * Cannot be null, empty, or blank
    ///
    /// * Must contain from 1 to 255 letters, numbers, or hyphens
    ///
    /// * First character must be a letter
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens
    ///
    /// Example: `my-cluster-param-group1`
    target_db_cluster_parameter_group_identifier: []const u8,
};

pub const CopyDBClusterParameterGroupOutput = struct {
    db_cluster_parameter_group: ?DBClusterParameterGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyDBClusterParameterGroupInput, options: CallOptions) !CopyDBClusterParameterGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyDBClusterParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CopyDBClusterParameterGroup&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&SourceDBClusterParameterGroupIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_db_cluster_parameter_group_identifier);
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
    try body_buf.appendSlice(allocator, "&TargetDBClusterParameterGroupDescription=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_db_cluster_parameter_group_description);
    try body_buf.appendSlice(allocator, "&TargetDBClusterParameterGroupIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_db_cluster_parameter_group_identifier);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyDBClusterParameterGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CopyDBClusterParameterGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CopyDBClusterParameterGroupOutput = .{};
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
