const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyFpgaImageAttributeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyFpgaImageAttributeInput, options: Options) !ModifyFpgaImageAttributeOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyFpgaImageAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyFpgaImageAttribute&Version=2016-11-15");
    if (input.attribute) |v| {
        try body_buf.appendSlice(alloc, "&Attribute=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&FpgaImageId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.fpga_image_id);
    if (input.load_permission) |v| {
        if (v.add) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadPermission.Add.item.{d}.Group=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.group) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadPermission.Add.item.{d}.UserId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.user_id) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
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
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.group) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadPermission.Remove.item.{d}.UserId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.user_id) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
            }
        }
    }
    if (input.name) |v| {
        try body_buf.appendSlice(alloc, "&Name=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.operation_type) |v| {
        try body_buf.appendSlice(alloc, "&OperationType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.product_codes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProductCode.ProductCode.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.user_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserGroup.UserGroup.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.user_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserId.UserId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyFpgaImageAttributeOutput {
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
                    result.fpga_image_attribute = try serde.deserializeFpgaImageAttribute(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
