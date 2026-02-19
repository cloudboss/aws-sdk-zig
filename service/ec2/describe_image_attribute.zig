const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ImageAttributeName = @import("image_attribute_name.zig").ImageAttributeName;
const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const LaunchPermission = @import("launch_permission.zig").LaunchPermission;
const ProductCode = @import("product_code.zig").ProductCode;
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeImageAttributeOutput) void {
        self._arena.deinit();
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeImageAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeImageAttribute&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&Attribute=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.attribute));
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ImageId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.image_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeImageAttributeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeImageAttributeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "blockDeviceMapping")) {
                    result.block_device_mappings = try serde.deserializeBlockDeviceMappingList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "bootMode")) {
                    result.boot_mode = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "deregistrationProtection")) {
                    result.deregistration_protection = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "description")) {
                    result.description = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "imageId")) {
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "imdsSupport")) {
                    result.imds_support = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "kernel")) {
                    result.kernel_id = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "lastLaunchedTime")) {
                    result.last_launched_time = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "launchPermission")) {
                    result.launch_permissions = try serde.deserializeLaunchPermissionList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "productCodes")) {
                    result.product_codes = try serde.deserializeProductCodeList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "ramdisk")) {
                    result.ramdisk_id = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "sriovNetSupport")) {
                    result.sriov_net_support = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "tpmSupport")) {
                    result.tpm_support = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "uefiData")) {
                    result.uefi_data = try serde.deserializeAttributeValue(&reader, alloc);
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
