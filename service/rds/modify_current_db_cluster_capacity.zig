const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ModifyCurrentDBClusterCapacityInput = struct {
    /// The DB cluster capacity.
    ///
    /// When you change the capacity of a paused Aurora Serverless v1 DB cluster, it
    /// automatically resumes.
    ///
    /// Constraints:
    ///
    /// * For Aurora MySQL, valid capacity values are `1`, `2`, `4`, `8`, `16`,
    ///   `32`, `64`, `128`, and `256`.
    /// * For Aurora PostgreSQL, valid capacity values are `2`, `4`, `8`, `16`,
    ///   `32`, `64`, `192`, and `384`.
    capacity: ?i32 = null,

    /// The DB cluster identifier for the cluster being modified. This parameter
    /// isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing DB cluster.
    db_cluster_identifier: []const u8,

    /// The amount of time, in seconds, that Aurora Serverless v1 tries to find a
    /// scaling point to perform seamless scaling before enforcing the timeout
    /// action. The default is 300.
    ///
    /// Specify a value between 10 and 600 seconds.
    seconds_before_timeout: ?i32 = null,

    /// The action to take when the timeout is reached, either
    /// `ForceApplyCapacityChange` or `RollbackCapacityChange`.
    ///
    /// `ForceApplyCapacityChange`, the default, sets the capacity to the specified
    /// value as soon as possible.
    ///
    /// `RollbackCapacityChange` ignores the capacity change if a scaling point
    /// isn't found in the timeout period.
    timeout_action: ?[]const u8 = null,
};

pub const ModifyCurrentDBClusterCapacityOutput = struct {
    /// The current capacity of the DB cluster.
    current_capacity: ?i32 = null,

    /// A user-supplied DB cluster identifier. This identifier is the unique key
    /// that identifies a DB cluster.
    db_cluster_identifier: ?[]const u8 = null,

    /// A value that specifies the capacity that the DB cluster scales to next.
    pending_capacity: ?i32 = null,

    /// The number of seconds before a call to `ModifyCurrentDBClusterCapacity`
    /// times out.
    seconds_before_timeout: ?i32 = null,

    /// The timeout action of a call to `ModifyCurrentDBClusterCapacity`, either
    /// `ForceApplyCapacityChange` or `RollbackCapacityChange`.
    timeout_action: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyCurrentDBClusterCapacityInput, options: CallOptions) !ModifyCurrentDBClusterCapacityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyCurrentDBClusterCapacityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyCurrentDBClusterCapacity&Version=2014-10-31");
    if (input.capacity) |v| {
        try body_buf.appendSlice(allocator, "&Capacity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    if (input.seconds_before_timeout) |v| {
        try body_buf.appendSlice(allocator, "&SecondsBeforeTimeout=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.timeout_action) |v| {
        try body_buf.appendSlice(allocator, "&TimeoutAction=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyCurrentDBClusterCapacityOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyCurrentDBClusterCapacityResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyCurrentDBClusterCapacityOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CurrentCapacity")) {
                    result.current_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingCapacity")) {
                    result.pending_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SecondsBeforeTimeout")) {
                    result.seconds_before_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TimeoutAction")) {
                    result.timeout_action = try allocator.dupe(u8, try reader.readElementText());
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
