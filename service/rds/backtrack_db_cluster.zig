const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const BacktrackDBClusterInput = struct {
    /// The timestamp of the time to backtrack the DB cluster to, specified in ISO
    /// 8601 format. For more information about ISO 8601, see the [ISO8601 Wikipedia
    /// page.](http://en.wikipedia.org/wiki/ISO_8601)
    ///
    /// If the specified time isn't a consistent time for the DB cluster, Aurora
    /// automatically chooses the nearest possible consistent time for the DB
    /// cluster.
    ///
    /// Constraints:
    ///
    /// * Must contain a valid ISO 8601 timestamp.
    /// * Can't contain a timestamp set in the future.
    ///
    /// Example: `2017-07-08T18:00Z`
    backtrack_to: i64,

    /// The DB cluster identifier of the DB cluster to be backtracked. This
    /// parameter is stored as a lowercase string.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 alphanumeric characters or hyphens.
    /// * First character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `my-cluster1`
    db_cluster_identifier: []const u8,

    /// Specifies whether to force the DB cluster to backtrack when binary logging
    /// is enabled. Otherwise, an error occurs when binary logging is enabled.
    force: ?bool = null,

    /// Specifies whether to backtrack the DB cluster to the earliest possible
    /// backtrack time when *BacktrackTo* is set to a timestamp earlier than the
    /// earliest backtrack time. When this parameter is disabled and *BacktrackTo*
    /// is set to a timestamp earlier than the earliest backtrack time, an error
    /// occurs.
    use_earliest_time_on_point_in_time_unavailable: ?bool = null,
};

pub const BacktrackDBClusterOutput = @import("db_cluster_backtrack.zig").DBClusterBacktrack;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BacktrackDBClusterInput, options: CallOptions) !BacktrackDBClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BacktrackDBClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=BacktrackDBCluster&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&BacktrackTo=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.backtrack_to}) catch "");
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    if (input.force) |v| {
        try body_buf.appendSlice(allocator, "&Force=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.use_earliest_time_on_point_in_time_unavailable) |v| {
        try body_buf.appendSlice(allocator, "&UseEarliestTimeOnPointInTimeUnavailable=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BacktrackDBClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BacktrackDBClusterResult")) break;
            },
            else => {},
        }
    }

    var result: BacktrackDBClusterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BacktrackedFrom")) {
                    result.backtracked_from = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "BacktrackIdentifier")) {
                    result.backtrack_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BacktrackRequestCreationTime")) {
                    result.backtrack_request_creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "BacktrackTo")) {
                    result.backtrack_to = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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
