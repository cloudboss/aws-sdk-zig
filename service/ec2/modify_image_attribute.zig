const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const LaunchPermissionModifications = @import("launch_permission_modifications.zig").LaunchPermissionModifications;
const OperationType = @import("operation_type.zig").OperationType;

/// Modifies the specified attribute of the specified AMI. You can specify only
/// one attribute
/// at a time.
///
/// To specify the attribute, you can use the `Attribute` parameter, or one of
/// the
/// following parameters: `Description`, `ImdsSupport`, or
/// `LaunchPermission`.
///
/// Images with an Amazon Web Services Marketplace product code cannot be made
/// public.
///
/// To enable the SriovNetSupport enhanced networking attribute of an image,
/// enable
/// SriovNetSupport on an instance and create an AMI from the instance.
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
    /// **Important:**
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

pub const ModifyImageAttributeOutput = struct {

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyImageAttributeOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyImageAttributeInput, options: Options) !ModifyImageAttributeOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyImageAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyImageAttribute&Version=2016-11-15");
    if (input.attribute) |v| {
        try body_buf.appendSlice(alloc, "&Attribute=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&Description.Value=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ImageId=");
    try appendUrlEncoded(alloc, &body_buf, input.image_id);
    if (input.imds_support) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&ImdsSupport.Value=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.operation_type) |v| {
        try body_buf.appendSlice(alloc, "&OperationType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.organizational_unit_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OrganizationalUnitArns.OrganizationalUnitArn.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.organization_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OrganizationArns.OrganizationArn.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.product_codes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProductCodes.ProductCode.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.user_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserGroups.UserGroup.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.user_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserIds.UserId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.value) |v| {
        try body_buf.appendSlice(alloc, "&Value=");
        try appendUrlEncoded(alloc, &body_buf, v);
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
    const result: ModifyImageAttributeOutput = .{ .allocator = alloc };

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
