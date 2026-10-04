const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalCluster = @import("global_cluster.zig").GlobalCluster;
const serde = @import("serde.zig");

pub const SwitchoverGlobalClusterInput = struct {
    /// The identifier of the Amazon DocumentDB global database cluster to switch
    /// over.
    /// The identifier is the unique key assigned by the user when the cluster is
    /// created.
    /// In other words, it's the name of the global cluster.
    /// This parameter isn’t case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing global cluster (Amazon DocumentDB
    ///   global database).
    ///
    /// * Minimum length of 1. Maximum length of 255.
    ///
    /// Pattern: `[A-Za-z][0-9A-Za-z-:._]*`
    global_cluster_identifier: []const u8,

    /// The identifier of the secondary Amazon DocumentDB cluster to promote to the
    /// new primary for the global database cluster.
    /// Use the Amazon Resource Name (ARN) for the identifier so that Amazon
    /// DocumentDB can locate the cluster in its Amazon Web Services region.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing secondary cluster.
    ///
    /// * Minimum length of 1. Maximum length of 255.
    ///
    /// Pattern: `[A-Za-z][0-9A-Za-z-:._]*`
    target_db_cluster_identifier: []const u8,
};

pub const SwitchoverGlobalClusterOutput = struct {
    global_cluster: ?GlobalCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SwitchoverGlobalClusterInput, options: CallOptions) !SwitchoverGlobalClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SwitchoverGlobalClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "DocDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SwitchoverGlobalCluster&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&GlobalClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.global_cluster_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SwitchoverGlobalClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SwitchoverGlobalClusterResult")) break;
            },
            else => {},
        }
    }

    var result: SwitchoverGlobalClusterOutput = .{};
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
