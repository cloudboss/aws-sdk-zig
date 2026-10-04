const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterSecurityGroup = @import("cluster_security_group.zig").ClusterSecurityGroup;
const serde = @import("serde.zig");

pub const DescribeClusterSecurityGroupsInput = struct {
    /// The name of a cluster security group for which you are requesting details.
    /// You must
    /// specify either the **Marker** parameter or a **ClusterSecurityGroupName**
    /// parameter, but not both.
    ///
    /// Example: `securitygroup1`
    cluster_security_group_name: ?[]const u8 = null,

    /// An optional parameter that specifies the starting point to return a set of
    /// response
    /// records. When the results of a DescribeClusterSecurityGroups request
    /// exceed the value specified in `MaxRecords`, Amazon Web Services returns a
    /// value in the
    /// `Marker` field of the response. You can retrieve the next set of response
    /// records by providing the returned marker value in the `Marker` parameter and
    /// retrying the request.
    ///
    /// Constraints: You must specify either the **ClusterSecurityGroupName**
    /// parameter or the **Marker** parameter, but not both.
    marker: ?[]const u8 = null,

    /// The maximum number of response records to return in each call. If the number
    /// of
    /// remaining response records exceeds the specified `MaxRecords` value, a value
    /// is returned in a `marker` field of the response. You can retrieve the next
    /// set of records by retrying the command with the returned marker value.
    ///
    /// Default: `100`
    ///
    /// Constraints: minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// A tag key or keys for which you want to return all matching cluster security
    /// groups
    /// that are associated with the specified key or keys. For example, suppose
    /// that you have
    /// security groups that are tagged with keys called `owner` and
    /// `environment`. If you specify both of these tag keys in the request,
    /// Amazon Redshift returns a response with the security groups that have either
    /// or both of these
    /// tag keys associated with them.
    tag_keys: ?[]const []const u8 = null,

    /// A tag value or values for which you want to return all matching cluster
    /// security
    /// groups that are associated with the specified tag value or values. For
    /// example, suppose
    /// that you have security groups that are tagged with values called `admin` and
    /// `test`. If you specify both of these tag values in the request, Amazon
    /// Redshift
    /// returns a response with the security groups that have either or both of
    /// these tag values
    /// associated with them.
    tag_values: ?[]const []const u8 = null,
};

pub const DescribeClusterSecurityGroupsOutput = struct {
    /// A list of ClusterSecurityGroup instances.
    cluster_security_groups: ?[]const ClusterSecurityGroup = null,

    /// A value that indicates the starting point for the next set of response
    /// records in a
    /// subsequent request. If a value is returned in a response, you can retrieve
    /// the next set
    /// of records by providing this returned marker value in the `Marker` parameter
    /// and retrying the command. If the `Marker` field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClusterSecurityGroupsInput, options: CallOptions) !DescribeClusterSecurityGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClusterSecurityGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeClusterSecurityGroups&Version=2012-12-01");
    if (input.cluster_security_group_name) |v| {
        try body_buf.appendSlice(allocator, "&ClusterSecurityGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.tag_keys) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagKeys.TagKey.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.tag_values) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagValues.TagValue.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClusterSecurityGroupsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeClusterSecurityGroupsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeClusterSecurityGroupsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterSecurityGroups")) {
                    result.cluster_security_groups = try serde.deserializeClusterSecurityGroups(allocator, &reader, "ClusterSecurityGroup");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
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
