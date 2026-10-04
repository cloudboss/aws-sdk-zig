const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ModifyClusterSnapshotScheduleInput = struct {
    /// A unique identifier for the cluster whose snapshot schedule you want to
    /// modify.
    cluster_identifier: []const u8,

    /// A boolean to indicate whether to remove the assoiciation between the cluster
    /// and the
    /// schedule.
    disassociate_schedule: ?bool = null,

    /// A unique alphanumeric identifier for the schedule that you want to associate
    /// with the
    /// cluster.
    schedule_identifier: ?[]const u8 = null,
};

pub const ModifyClusterSnapshotScheduleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyClusterSnapshotScheduleInput, options: CallOptions) !ModifyClusterSnapshotScheduleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyClusterSnapshotScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyClusterSnapshotSchedule&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.disassociate_schedule) |v| {
        try body_buf.appendSlice(allocator, "&DisassociateSchedule=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.schedule_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ScheduleIdentifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyClusterSnapshotScheduleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: ModifyClusterSnapshotScheduleOutput = .{};

    return result;
}
