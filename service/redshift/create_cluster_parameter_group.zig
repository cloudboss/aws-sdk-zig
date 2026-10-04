const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ClusterParameterGroup = @import("cluster_parameter_group.zig").ClusterParameterGroup;
const serde = @import("serde.zig");

pub const CreateClusterParameterGroupInput = struct {
    /// A description of the parameter group.
    description: []const u8,

    /// The Amazon Redshift engine version to which the cluster parameter group
    /// applies. The
    /// cluster engine version determines the set of parameters.
    ///
    /// To get a list of valid parameter group family names, you can call
    /// DescribeClusterParameterGroups. By default, Amazon Redshift returns a list
    /// of
    /// all the parameter groups that are owned by your Amazon Web Services account,
    /// including the default
    /// parameter groups for each Amazon Redshift engine version. The parameter
    /// group family names
    /// associated with the default parameter groups provide you the valid values.
    /// For example,
    /// a valid family name is "redshift-1.0".
    parameter_group_family: []const u8,

    /// The name of the cluster parameter group.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 alphanumeric characters or hyphens
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    ///
    /// * Must be unique withing your Amazon Web Services account.
    ///
    /// This value is stored as a lower-case string.
    parameter_group_name: []const u8,

    /// A list of tag instances.
    tags: ?[]const Tag = null,
};

pub const CreateClusterParameterGroupOutput = struct {
    cluster_parameter_group: ?ClusterParameterGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterParameterGroupInput, options: CallOptions) !CreateClusterParameterGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateClusterParameterGroup&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&Description=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.description);
    try body_buf.appendSlice(allocator, "&ParameterGroupFamily=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.parameter_group_family);
    try body_buf.appendSlice(allocator, "&ParameterGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.parameter_group_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterParameterGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateClusterParameterGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateClusterParameterGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterParameterGroup")) {
                    result.cluster_parameter_group = try serde.deserializeClusterParameterGroup(allocator, &reader);
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
