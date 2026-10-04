const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Snapshot = @import("snapshot.zig").Snapshot;
const serde = @import("serde.zig");

pub const AuthorizeSnapshotAccessInput = struct {
    /// The identifier of the Amazon Web Services account authorized to restore the
    /// specified
    /// snapshot.
    ///
    /// To share a snapshot with Amazon Web Services Support, specify
    /// amazon-redshift-support.
    account_with_restore_access: []const u8,

    /// The Amazon Resource Name (ARN) of the snapshot to authorize access to.
    snapshot_arn: ?[]const u8 = null,

    /// The identifier of the cluster the snapshot was created from.
    ///
    /// * *If the snapshot to access doesn't exist and the associated IAM policy
    ///   doesn't allow access to all (*) snapshots* - This parameter is required.
    ///   Otherwise, permissions
    /// aren't available to check if the snapshot exists.
    ///
    /// * *If the snapshot to access exists* - This parameter isn't required.
    ///   Redshift can retrieve the cluster identifier and use it to
    /// validate snapshot authorization.
    snapshot_cluster_identifier: ?[]const u8 = null,

    /// The identifier of the snapshot the account is authorized to restore.
    snapshot_identifier: ?[]const u8 = null,
};

pub const AuthorizeSnapshotAccessOutput = struct {
    snapshot: ?Snapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AuthorizeSnapshotAccessInput, options: CallOptions) !AuthorizeSnapshotAccessOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AuthorizeSnapshotAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=AuthorizeSnapshotAccess&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&AccountWithRestoreAccess=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.account_with_restore_access);
    if (input.snapshot_arn) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotClusterIdentifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AuthorizeSnapshotAccessOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthorizeSnapshotAccessResult")) break;
            },
            else => {},
        }
    }

    var result: AuthorizeSnapshotAccessOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Snapshot")) {
                    result.snapshot = try serde.deserializeSnapshot(allocator, &reader);
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
