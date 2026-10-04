const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBSnapshotAttributesResult = @import("db_snapshot_attributes_result.zig").DBSnapshotAttributesResult;
const serde = @import("serde.zig");

pub const ModifyDBSnapshotAttributeInput = struct {
    /// The name of the DB snapshot attribute to modify.
    ///
    /// To manage authorization for other Amazon Web Services accounts to copy or
    /// restore a manual DB snapshot, set this value to `restore`.
    ///
    /// To view the list of attributes available to modify, use the
    /// DescribeDBSnapshotAttributes API operation.
    attribute_name: []const u8,

    /// The identifier for the DB snapshot to modify the attributes for.
    db_snapshot_identifier: []const u8,

    /// A list of DB snapshot attributes to add to the attribute specified by
    /// `AttributeName`.
    ///
    /// To authorize other Amazon Web Services accounts to copy or restore a manual
    /// snapshot, set this list to include one or more Amazon Web Services account
    /// IDs, or `all` to make the manual DB snapshot restorable by any Amazon Web
    /// Services account. Do not add the `all` value for any manual DB snapshots
    /// that contain private information that you don't want available to all Amazon
    /// Web Services accounts.
    values_to_add: ?[]const []const u8 = null,

    /// A list of DB snapshot attributes to remove from the attribute specified by
    /// `AttributeName`.
    ///
    /// To remove authorization for other Amazon Web Services accounts to copy or
    /// restore a manual snapshot, set this list to include one or more Amazon Web
    /// Services account identifiers, or `all` to remove authorization for any
    /// Amazon Web Services account to copy or restore the DB snapshot. If you
    /// specify `all`, an Amazon Web Services account whose account ID is explicitly
    /// added to the `restore` attribute can still copy or restore the manual DB
    /// snapshot.
    values_to_remove: ?[]const []const u8 = null,
};

pub const ModifyDBSnapshotAttributeOutput = struct {
    db_snapshot_attributes_result: ?DBSnapshotAttributesResult = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBSnapshotAttributeInput, options: CallOptions) !ModifyDBSnapshotAttributeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBSnapshotAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBSnapshotAttribute&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&AttributeName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.attribute_name);
    try body_buf.appendSlice(allocator, "&DBSnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_snapshot_identifier);
    if (input.values_to_add) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ValuesToAdd.AttributeValue.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.values_to_remove) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ValuesToRemove.AttributeValue.{d}=", .{n}) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBSnapshotAttributeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBSnapshotAttributeResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBSnapshotAttributeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSnapshotAttributesResult")) {
                    result.db_snapshot_attributes_result = try serde.deserializeDBSnapshotAttributesResult(allocator, &reader);
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
