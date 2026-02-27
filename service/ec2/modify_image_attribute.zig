const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const LaunchPermissionModifications = @import("launch_permission_modifications.zig").LaunchPermissionModifications;
const OperationType = @import("operation_type.zig").OperationType;
const serde = @import("serde.zig");

pub const ModifyImageAttributeInput = struct {
    /// The name of the attribute to modify.
    ///
    /// Valid values: `description` | `imdsSupport` |
    /// `launchPermission`
    attribute: ?[]const u8 = null,

    /// A new description for the AMI.
    description: ?AttributeValue = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the AMI.
    image_id: []const u8,

    /// Set to `v2.0` to indicate that IMDSv2 is specified in the AMI. Instances
    /// launched from this AMI will have `HttpTokens` automatically set to
    /// `required` so that, by default, the instance requires that IMDSv2 is used
    /// when
    /// requesting instance metadata. In addition, `HttpPutResponseHopLimit` is set
    /// to
    /// `2`. For more information, see [Configure the
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-new-instances.html#configure-IMDS-new-instances-ami-configuration) in the *Amazon EC2 User Guide*.
    ///
    /// Do not use this parameter unless your AMI software supports IMDSv2. After
    /// you set the
    /// value to `v2.0`, you can't undo it. The only way to “reset” your AMI is to
    /// create
    /// a new AMI from the underlying snapshot.
    imds_support: ?AttributeValue = null,

    /// A new launch permission for the AMI.
    launch_permission: ?LaunchPermissionModifications = null,

    /// The operation type. This parameter can be used only when the `Attribute`
    /// parameter is `launchPermission`.
    operation_type: ?OperationType = null,

    /// The Amazon Resource Name (ARN) of an organizational unit (OU). This
    /// parameter can be used
    /// only when the `Attribute` parameter is `launchPermission`.
    organizational_unit_arns: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of an organization. This parameter can be
    /// used only when
    /// the `Attribute` parameter is `launchPermission`.
    organization_arns: ?[]const []const u8 = null,

    /// Not supported.
    product_codes: ?[]const []const u8 = null,

    /// The user groups. This parameter can be used only when the `Attribute`
    /// parameter
    /// is `launchPermission`.
    user_groups: ?[]const []const u8 = null,

    /// The Amazon Web Services account IDs. This parameter can be used only when
    /// the
    /// `Attribute` parameter is `launchPermission`.
    user_ids: ?[]const []const u8 = null,

    /// The value of the attribute being modified. This parameter can be used only
    /// when the
    /// `Attribute` parameter is `description` or
    /// `imdsSupport`.
    value: ?[]const u8 = null,
};

pub const ModifyImageAttributeOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyImageAttributeInput, options: Options) !ModifyImageAttributeOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyImageAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyImageAttribute&Version=2016-11-15");
    if (input.attribute) |v| {
        try body_buf.appendSlice(alloc, "&Attribute=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&Description.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ImageId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.image_id);
    if (input.imds_support) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&ImdsSupport.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.launch_permission) |v| {
        if (v.add) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchPermission.Add.item.{d}.Group=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.group) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchPermission.Add.item.{d}.OrganizationalUnitArn=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.organizational_unit_arn) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchPermission.Add.item.{d}.OrganizationArn=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.organization_arn) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchPermission.Add.item.{d}.UserId=", .{n}) catch continue;
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchPermission.Remove.item.{d}.Group=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.group) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchPermission.Remove.item.{d}.OrganizationalUnitArn=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.organizational_unit_arn) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchPermission.Remove.item.{d}.OrganizationArn=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.organization_arn) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchPermission.Remove.item.{d}.UserId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.user_id) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
            }
        }
    }
    if (input.operation_type) |v| {
        try body_buf.appendSlice(alloc, "&OperationType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.organizational_unit_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OrganizationalUnitArn.OrganizationalUnitArn.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.organization_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OrganizationArn.OrganizationArn.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
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
    if (input.value) |v| {
        try body_buf.appendSlice(alloc, "&Value=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyImageAttributeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: ModifyImageAttributeOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
