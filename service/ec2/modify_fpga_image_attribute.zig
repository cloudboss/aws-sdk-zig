const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FpgaImageAttributeName = @import("fpga_image_attribute_name.zig").FpgaImageAttributeName;
const LoadPermissionModifications = @import("load_permission_modifications.zig").LoadPermissionModifications;
const OperationType = @import("operation_type.zig").OperationType;
const FpgaImageAttribute = @import("fpga_image_attribute.zig").FpgaImageAttribute;
const serde = @import("serde.zig");

pub const ModifyFpgaImageAttributeInput = struct {
    /// The name of the attribute.
    attribute: ?FpgaImageAttributeName = null,

    /// A description for the AFI.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the AFI.
    fpga_image_id: []const u8,

    /// The load permission for the AFI.
    load_permission: ?LoadPermissionModifications = null,

    /// A name for the AFI.
    name: ?[]const u8 = null,

    /// The operation type.
    operation_type: ?OperationType = null,

    /// The product codes. After you add a product code to an AFI, it can't be
    /// removed.
    /// This parameter is valid only when modifying the `productCodes` attribute.
    product_codes: ?[]const []const u8 = null,

    /// The user groups. This parameter is valid only when modifying the
    /// `loadPermission` attribute.
    user_groups: ?[]const []const u8 = null,

    /// The Amazon Web Services account IDs. This parameter is valid only when
    /// modifying the `loadPermission` attribute.
    user_ids: ?[]const []const u8 = null,
};

pub const ModifyFpgaImageAttributeOutput = struct {
    /// Information about the attribute.
    fpga_image_attribute: ?FpgaImageAttribute = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyFpgaImageAttributeInput, options: CallOptions) !ModifyFpgaImageAttributeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyFpgaImageAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyFpgaImageAttribute&Version=2016-11-15");
    if (input.attribute) |v| {
        try body_buf.appendSlice(allocator, "&Attribute=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&FpgaImageId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.fpga_image_id);
    if (input.load_permission) |v| {
        if (v.add) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadPermission.Add.item.{d}.Group=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.group) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadPermission.Add.item.{d}.UserId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.user_id) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
            }
        }
        if (v.remove) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadPermission.Remove.item.{d}.Group=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.group) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadPermission.Remove.item.{d}.UserId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.user_id) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
            }
        }
    }
    if (input.name) |v| {
        try body_buf.appendSlice(allocator, "&Name=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.operation_type) |v| {
        try body_buf.appendSlice(allocator, "&OperationType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.product_codes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProductCode.ProductCode.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.user_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserGroup.UserGroup.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.user_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserId.UserId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyFpgaImageAttributeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyFpgaImageAttributeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "fpgaImageAttribute")) {
                    result.fpga_image_attribute = try serde.deserializeFpgaImageAttribute(allocator, &reader);
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
