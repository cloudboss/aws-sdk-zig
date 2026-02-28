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
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstanceAttributeInput, options: Options) !DescribeInstanceAttributeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeInstanceAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeInstanceAttribute&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&Attribute=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.attribute));
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeInstanceAttributeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeInstanceAttributeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "blockDeviceMapping")) {
                    result.block_device_mappings = try serde.deserializeInstanceBlockDeviceMappingList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "disableApiStop")) {
                    result.disable_api_stop = try serde.deserializeAttributeBooleanValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "disableApiTermination")) {
                    result.disable_api_termination = try serde.deserializeAttributeBooleanValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ebsOptimized")) {
                    result.ebs_optimized = try serde.deserializeAttributeBooleanValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "enaSupport")) {
                    result.ena_support = try serde.deserializeAttributeBooleanValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "enclaveOptions")) {
                    result.enclave_options = try serde.deserializeEnclaveOptions(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "groupSet")) {
                    result.groups = try serde.deserializeGroupIdentifierList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "instanceId")) {
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "instanceInitiatedShutdownBehavior")) {
                    result.instance_initiated_shutdown_behavior = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "instanceType")) {
                    result.instance_type = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "kernel")) {
                    result.kernel_id = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "productCodes")) {
                    result.product_codes = try serde.deserializeProductCodeList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "ramdisk")) {
                    result.ramdisk_id = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "rootDeviceName")) {
                    result.root_device_name = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "sourceDestCheck")) {
                    result.source_dest_check = try serde.deserializeAttributeBooleanValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "sriovNetSupport")) {
                    result.sriov_net_support = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "userData")) {
                    result.user_data = try serde.deserializeAttributeValue(&reader, alloc);
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
