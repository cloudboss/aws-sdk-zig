const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterDbRevision = @import("cluster_db_revision.zig").ClusterDbRevision;
const serde = @import("serde.zig");

pub const DescribeClusterDbRevisionsInput = struct {
    /// A unique identifier for a cluster whose `ClusterDbRevisions` you are
    /// requesting. This parameter is case sensitive. All clusters defined for an
    /// account are
    /// returned by default.
    cluster_identifier: ?[]const u8 = null,

    /// An optional parameter that specifies the starting point for returning a set
    /// of
    /// response records. When the results of a `DescribeClusterDbRevisions` request
    /// exceed the value specified in `MaxRecords`, Amazon Redshift returns a value
    /// in the `marker` field of the response. You can retrieve the next set of
    /// response records by providing the returned `marker` value in the
    /// `marker` parameter and retrying the request.
    ///
    /// Constraints: You can specify either the `ClusterIdentifier` parameter, or
    /// the `marker` parameter, but not both.
    marker: ?[]const u8 = null,

    /// The maximum number of response records to return in each call. If the number
    /// of
    /// remaining response records exceeds the specified MaxRecords value, a value
    /// is returned
    /// in the `marker` field of the response. You can retrieve the next set of
    /// response records by providing the returned `marker` value in the
    /// `marker` parameter and retrying the request.
    ///
    /// Default: 100
    ///
    /// Constraints: minimum 20, maximum 100.
    max_records: ?i32 = null,
};

pub const DescribeClusterDbRevisionsOutput = struct {
    /// A list of revisions.
    cluster_db_revisions: ?[]const ClusterDbRevision = null,

    /// A string representing the starting point for the next set of revisions. If a
    /// value is
    /// returned in a response, you can retrieve the next set of revisions by
    /// providing the
    /// value in the `marker` parameter and retrying the command. If the
    /// `marker` field is empty, all revisions have already been returned.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClusterDbRevisionsInput, options: CallOptions) !DescribeClusterDbRevisionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClusterDbRevisionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeClusterDbRevisions&Version=2012-12-01");
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClusterDbRevisionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeClusterDbRevisionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeClusterDbRevisionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterDbRevisions")) {
                    result.cluster_db_revisions = try serde.deserializeClusterDbRevisionsList(allocator, &reader, "ClusterDbRevision");
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
