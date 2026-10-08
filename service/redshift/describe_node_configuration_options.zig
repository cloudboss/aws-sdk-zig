const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionType = @import("action_type.zig").ActionType;
const NodeConfigurationOptionsFilter = @import("node_configuration_options_filter.zig").NodeConfigurationOptionsFilter;
const NodeConfigurationOption = @import("node_configuration_option.zig").NodeConfigurationOption;
const serde = @import("serde.zig");

pub const DescribeNodeConfigurationOptionsInput = struct {
    /// The action type to evaluate for possible node configurations.
    /// Specify "restore-cluster" to get configuration combinations based on an
    /// existing snapshot.
    /// Specify "recommend-node-config" to get configuration recommendations based
    /// on an existing cluster or snapshot.
    /// Specify "resize-cluster" to get configuration combinations for elastic
    /// resize based on an existing cluster.
    action_type: ActionType,

    /// The identifier of the cluster to evaluate for possible node configurations.
    cluster_identifier: ?[]const u8 = null,

    /// A set of name, operator, and value items to filter the results.
    filters: ?[]const NodeConfigurationOptionsFilter = null,

    /// An optional parameter that specifies the starting point to return a set of
    /// response
    /// records. When the results of a DescribeNodeConfigurationOptions request
    /// exceed the value specified in `MaxRecords`, Amazon Web Services returns a
    /// value in the
    /// `Marker` field of the response. You can retrieve the next set of response
    /// records by providing the returned marker value in the `Marker` parameter and
    /// retrying the request.
    marker: ?[]const u8 = null,

    /// The maximum number of response records to return in each call. If the number
    /// of
    /// remaining response records exceeds the specified `MaxRecords` value, a value
    /// is returned in a `marker` field of the response. You can retrieve the next
    /// set of records by retrying the command with the returned marker value.
    ///
    /// Default: `500`
    ///
    /// Constraints: minimum 100, maximum 500.
    max_records: ?i32 = null,

    /// The Amazon Web Services account used to create or copy the snapshot.
    /// Required if you are restoring a snapshot you do not own,
    /// optional if you own the snapshot.
    owner_account: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the snapshot associated with the message
    /// to describe node configuration.
    snapshot_arn: ?[]const u8 = null,

    /// The identifier of the snapshot to evaluate for possible node configurations.
    snapshot_identifier: ?[]const u8 = null,
};

pub const DescribeNodeConfigurationOptionsOutput = struct {
    /// A value that indicates the starting point for the next set of response
    /// records in a
    /// subsequent request. If a value is returned in a response, you can retrieve
    /// the next set
    /// of records by providing this returned marker value in the `Marker` parameter
    /// and retrying the command. If the `Marker` field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8 = null,

    /// A list of valid node configurations.
    node_configuration_option_list: ?[]const NodeConfigurationOption = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeNodeConfigurationOptionsInput, options: CallOptions) !DescribeNodeConfigurationOptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeNodeConfigurationOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeNodeConfigurationOptions&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ActionType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.action_type.wireName());
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.NodeConfigurationOptionsFilter.{d}.Name=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.operator) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.NodeConfigurationOptionsFilter.{d}.Operator=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.NodeConfigurationOptionsFilter.{d}.Value.item.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.owner_account) |v| {
        try body_buf.appendSlice(allocator, "&OwnerAccount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_arn) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotIdentifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeNodeConfigurationOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeNodeConfigurationOptionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeNodeConfigurationOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeConfigurationOptionList")) {
                    result.node_configuration_option_list = try serde.deserializeNodeConfigurationOptionList(allocator, &reader, "NodeConfigurationOption");
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
