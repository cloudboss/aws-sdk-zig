const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceAttributeName = @import("instance_attribute_name.zig").InstanceAttributeName;
const InstanceBlockDeviceMapping = @import("instance_block_device_mapping.zig").InstanceBlockDeviceMapping;
const AttributeBooleanValue = @import("attribute_boolean_value.zig").AttributeBooleanValue;
const EnclaveOptions = @import("enclave_options.zig").EnclaveOptions;
const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const ProductCode = @import("product_code.zig").ProductCode;

/// Describes the specified attribute of the specified instance. You can specify
/// only one
/// attribute at a time. Available attributes include SQL license exemption
/// configuration
/// for instances registered with the SQL LE service.
pub const DescribeInstanceAttributeInput = struct {
    /// The instance attribute.
    ///
    /// Note that the `enaSupport` attribute is not supported.
    attribute: InstanceAttributeName,

    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the instance.
    instance_id: []const u8,
};

pub const DescribeInstanceAttributeOutput = struct {
    /// The block device mapping of the instance.
    block_device_mappings: ?[]const InstanceBlockDeviceMapping = null,

    /// Indicates whether stop protection is enabled for the instance.
    disable_api_stop: ?AttributeBooleanValue = null,

    /// Indicates whether termination protection is enabled. If the value is `true`,
    /// you can't terminate the instance using the Amazon EC2 console, command line
    /// tools, or API.
    disable_api_termination: ?AttributeBooleanValue = null,

    /// Indicates whether the instance is optimized for Amazon EBS I/O.
    ebs_optimized: ?AttributeBooleanValue = null,

    /// Indicates whether enhanced networking with ENA is enabled.
    ena_support: ?AttributeBooleanValue = null,

    /// Indicates whether the instance is enabled for Amazon Web Services Nitro
    /// Enclaves.
    enclave_options: ?EnclaveOptions = null,

    /// The security groups associated with the instance.
    groups: ?[]const GroupIdentifier = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// Indicates whether an instance stops or terminates when you initiate shutdown
    /// from the
    /// instance (using the operating system command for system shutdown).
    instance_initiated_shutdown_behavior: ?AttributeValue = null,

    /// The instance type.
    instance_type: ?AttributeValue = null,

    /// The kernel ID.
    kernel_id: ?AttributeValue = null,

    /// The product codes.
    product_codes: ?[]const ProductCode = null,

    /// The RAM disk ID.
    ramdisk_id: ?AttributeValue = null,

    /// The device name of the root device volume (for example,
    /// `/dev/sda1`).
    root_device_name: ?AttributeValue = null,

    /// Indicates whether source/destination checks are enabled.
    source_dest_check: ?AttributeBooleanValue = null,

    /// Indicates whether enhanced networking with the Intel 82599 Virtual Function
    /// interface
    /// is enabled.
    sriov_net_support: ?AttributeValue = null,

    /// The user data.
    user_data: ?AttributeValue = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const DescribeInstanceAttributeOutput) void {
        if (self.instance_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeInstanceAttributeInput, options: Options) !DescribeInstanceAttributeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeInstanceAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeInstanceAttribute&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&Attribute=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.attribute));
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try appendUrlEncoded(alloc, &body_buf, input.instance_id);

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !DescribeInstanceAttributeOutput {
    _ = status;
    var result: DescribeInstanceAttributeOutput = .{ .allocator = alloc };
    if (findElement(body, "instanceId")) |content| {
        result.instance_id = try alloc.dupe(u8, content);
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
