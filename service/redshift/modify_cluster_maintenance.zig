const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;
const serde = @import("serde.zig");

pub const ModifyClusterMaintenanceInput = struct {
    /// A unique identifier for the cluster.
    cluster_identifier: []const u8,

    /// A boolean indicating whether to enable the deferred maintenance window.
    defer_maintenance: ?bool = null,

    /// An integer indicating the duration of the maintenance window in days. If you
    /// specify a
    /// duration, you can't specify an end time. The duration must be 60 days or
    /// less.
    defer_maintenance_duration: ?i32 = null,

    /// A timestamp indicating end time for the deferred maintenance window. If you
    /// specify an
    /// end time, you can't specify a duration.
    defer_maintenance_end_time: ?i64 = null,

    /// A unique identifier for the deferred maintenance window.
    defer_maintenance_identifier: ?[]const u8 = null,

    /// A timestamp indicating the start time for the deferred maintenance window.
    defer_maintenance_start_time: ?i64 = null,
};

pub const ModifyClusterMaintenanceOutput = struct {
    cluster: ?Cluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyClusterMaintenanceInput, options: CallOptions) !ModifyClusterMaintenanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyClusterMaintenanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyClusterMaintenance&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.defer_maintenance) |v| {
        try body_buf.appendSlice(allocator, "&DeferMaintenance=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.defer_maintenance_duration) |v| {
        try body_buf.appendSlice(allocator, "&DeferMaintenanceDuration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.defer_maintenance_end_time) |v| {
        try body_buf.appendSlice(allocator, "&DeferMaintenanceEndTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.defer_maintenance_identifier) |v| {
        try body_buf.appendSlice(allocator, "&DeferMaintenanceIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.defer_maintenance_start_time) |v| {
        try body_buf.appendSlice(allocator, "&DeferMaintenanceStartTime=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyClusterMaintenanceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyClusterMaintenanceResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyClusterMaintenanceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cluster")) {
                    result.cluster = try serde.deserializeCluster(allocator, &reader);
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
