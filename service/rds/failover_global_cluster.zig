const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalCluster = @import("global_cluster.zig").GlobalCluster;
const serde = @import("serde.zig");

pub const FailoverGlobalClusterInput = struct {
    /// Specifies whether to allow data loss for this global database cluster
    /// operation. Allowing data loss triggers a global failover operation.
    ///
    /// If you don't specify `AllowDataLoss`, the global database cluster operation
    /// defaults to a switchover.
    ///
    /// Constraints:
    ///
    /// * Can't be specified together with the `Switchover` parameter.
    allow_data_loss: ?bool = null,

    /// The identifier of the global database cluster (Aurora global database) this
    /// operation should apply to. The identifier is the unique key assigned by the
    /// user when the Aurora global database is created. In other words, it's the
    /// name of the Aurora global database.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing global database cluster.
    global_cluster_identifier: []const u8,

    /// Specifies whether to switch over this global database cluster.
    ///
    /// Constraints:
    ///
    /// * Can't be specified together with the `AllowDataLoss` parameter.
    switchover: ?bool = null,

    /// The identifier of the secondary Aurora DB cluster that you want to promote
    /// to the primary for the global database cluster. Use the Amazon Resource Name
    /// (ARN) for the identifier so that Aurora can locate the cluster in its Amazon
    /// Web Services Region.
    target_db_cluster_identifier: []const u8,
};

pub const FailoverGlobalClusterOutput = struct {
    global_cluster: ?GlobalCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: FailoverGlobalClusterInput, options: CallOptions) !FailoverGlobalClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: FailoverGlobalClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=FailoverGlobalCluster&Version=2014-10-31");
    if (input.allow_data_loss) |v| {
        try body_buf.appendSlice(allocator, "&AllowDataLoss=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&GlobalClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.global_cluster_identifier);
    if (input.switchover) |v| {
        try body_buf.appendSlice(allocator, "&Switchover=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&TargetDbClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_db_cluster_identifier);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !FailoverGlobalClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailoverGlobalClusterResult")) break;
            },
            else => {},
        }
    }

    var result: FailoverGlobalClusterOutput = .{};
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
