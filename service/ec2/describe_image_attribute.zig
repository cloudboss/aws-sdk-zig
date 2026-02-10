const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ImageAttributeName = @import("image_attribute_name.zig").ImageAttributeName;
const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const LaunchPermission = @import("launch_permission.zig").LaunchPermission;
const ProductCode = @import("product_code.zig").ProductCode;

/// Describes the specified attribute of the specified AMI. You can specify only
/// one attribute
/// at a time.
///
/// **Note:**
///
/// The order of the elements in the response, including those within nested
/// structures,
/// might vary. Applications should not assume the elements appear in a
/// particular order.
pub const DescribeImageAttributeInput = struct {
    /// The AMI attribute.
    ///
    /// **Note**: The `blockDeviceMapping` attribute is
    /// deprecated. Using this attribute returns the `Client.AuthFailure` error. To
    /// get
    /// information about the block device mappings for an AMI, describe the image
    /// instead.
    attribute: ImageAttributeName,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the AMI.
    image_id: []const u8,
};

pub const DescribeImageAttributeOutput = struct {
    /// The block device mapping entries.
    block_device_mappings: ?[]const BlockDeviceMapping = null,

    /// The boot mode.
    boot_mode: ?AttributeValue = null,

    /// Indicates whether deregistration protection is enabled for the AMI.
    deregistration_protection: ?AttributeValue = null,

    /// A description for the AMI.
    description: ?AttributeValue = null,

    /// The ID of the AMI.
    image_id: ?[]const u8 = null,

    /// If `v2.0`, it indicates that IMDSv2 is specified in the AMI. Instances
    /// launched
    /// from this AMI will have `HttpTokens` automatically set to `required` so
    /// that, by default, the instance requires that IMDSv2 is used when requesting
    /// instance metadata.
    /// In addition, `HttpPutResponseHopLimit` is set to `2`. For more
    /// information, see [Configure the
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-new-instances.html#configure-IMDS-new-instances-ami-configuration) in the *Amazon EC2 User Guide*.
    imds_support: ?AttributeValue = null,

    /// The kernel ID.
    kernel_id: ?AttributeValue = null,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the AMI was last used to
    /// launch an EC2 instance. When the AMI is used
    /// to launch an instance, there is a 24-hour delay before that usage is
    /// reported.
    ///
    /// **Note:**
    ///
    /// `lastLaunchedTime` data is available starting April 2017.
    last_launched_time: ?AttributeValue = null,

    /// The launch permissions.
    launch_permissions: ?[]const LaunchPermission = null,

    /// The product codes.
    product_codes: ?[]const ProductCode = null,

    /// The RAM disk ID.
    ramdisk_id: ?AttributeValue = null,

    /// Indicates whether enhanced networking with the Intel 82599 Virtual Function
    /// interface is
    /// enabled.
    sriov_net_support: ?AttributeValue = null,

    /// If the image is configured for NitroTPM support, the value is `v2.0`.
    tpm_support: ?AttributeValue = null,

    /// Base64 representation of the non-volatile UEFI variable store. To retrieve
    /// the UEFI data,
    /// use the
    /// [GetInstanceUefiData](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_GetInstanceUefiData) command. You can inspect and modify the UEFI data by using the
    /// [python-uefivars tool](https://github.com/awslabs/python-uefivars) on
    /// GitHub. For more information, see [UEFI Secure Boot for Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/uefi-secure-boot.html) in the *Amazon EC2 User Guide*.
    uefi_data: ?AttributeValue = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const DescribeImageAttributeOutput) void {
        if (self.image_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeImageAttributeInput, options: Options) !DescribeImageAttributeOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeImageAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeImageAttribute&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&Attribute=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.attribute));
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ImageId=");
    try appendUrlEncoded(alloc, &body_buf, input.image_id);

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !DescribeImageAttributeOutput {
    _ = status;
    var result: DescribeImageAttributeOutput = .{ .allocator = alloc };
    if (findElement(body, "imageId")) |content| {
        result.image_id = try alloc.dupe(u8, content);
    }

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
