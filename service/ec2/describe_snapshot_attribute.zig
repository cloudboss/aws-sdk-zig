const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotAttributeName = @import("snapshot_attribute_name.zig").SnapshotAttributeName;
const CreateVolumePermission = @import("create_volume_permission.zig").CreateVolumePermission;
const ProductCode = @import("product_code.zig").ProductCode;
const serde = @import("serde.zig");

pub const DescribeSnapshotAttributeInput = struct {
    /// The snapshot attribute you would like to view.
    attribute: SnapshotAttributeName,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the EBS snapshot.
    snapshot_id: []const u8,
};

pub const DescribeSnapshotAttributeOutput = struct {
    /// The users and groups that have the permissions for creating volumes from the
    /// snapshot.
    create_volume_permissions: ?[]const CreateVolumePermission = null,

    /// The product codes.
    product_codes: ?[]const ProductCode = null,

    /// The ID of the EBS snapshot.
    snapshot_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSnapshotAttributeInput, options: CallOptions) !DescribeSnapshotAttributeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSnapshotAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeSnapshotAttribute&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&Attribute=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.attribute.wireName());
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&SnapshotId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.snapshot_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSnapshotAttributeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeSnapshotAttributeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "createVolumePermission")) {
                    result.create_volume_permissions = try serde.deserializeCreateVolumePermissionList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "productCodes")) {
                    result.product_codes = try serde.deserializeProductCodeList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "snapshotId")) {
                    result.snapshot_id = try allocator.dupe(u8, try reader.readElementText());
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
