const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ArchitectureValues = @import("architecture_values.zig").ArchitectureValues;
const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const BootModeValues = @import("boot_mode_values.zig").BootModeValues;
const ImdsSupportValues = @import("imds_support_values.zig").ImdsSupportValues;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TpmSupportValues = @import("tpm_support_values.zig").TpmSupportValues;
const serde = @import("serde.zig");

pub const RegisterImageInput = struct {
    /// The architecture of the AMI.
    ///
    /// Default: For Amazon EBS-backed AMIs, `i386`. For instance store-backed AMIs,
    /// the
    /// architecture specified in the manifest file.
    architecture: ?ArchitectureValues = null,

    /// The billing product codes. Your account must be authorized to specify
    /// billing product
    /// codes.
    ///
    /// If your account is not authorized to specify billing product codes, you can
    /// publish AMIs
    /// that include billable software and list them on the Amazon Web Services
    /// Marketplace. You must first register as a seller
    /// on the Amazon Web Services Marketplace. For more information, see [Getting
    /// started as an Amazon Web Services Marketplace
    /// seller](https://docs.aws.amazon.com/marketplace/latest/userguide/user-guide-for-sellers.html) and [AMI-based products in Amazon Web Services Marketplace](https://docs.aws.amazon.com/marketplace/latest/userguide/ami-products.html) in the *Amazon Web Services Marketplace Seller Guide*.
    billing_products: ?[]const []const u8 = null,

    /// The block device mapping entries.
    ///
    /// If you specify an Amazon EBS volume using the ID of an Amazon EBS snapshot,
    /// you can't specify the
    /// encryption state of the volume.
    ///
    /// If you create an AMI on an Outpost, then all backing snapshots must be on
    /// the same Outpost
    /// or in the Region of that Outpost. AMIs on an Outpost that include local
    /// snapshots can be used
    /// to launch instances on the same Outpost only. For more information, [Create
    /// AMIs from
    /// local
    /// snapshots](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html#ami) in the *Amazon EBS User Guide*.
    block_device_mappings: ?[]const BlockDeviceMapping = null,

    /// The boot mode of the AMI. A value of `uefi-preferred` indicates that the AMI
    /// supports both UEFI and Legacy BIOS.
    ///
    /// The operating system contained in the AMI must be configured to support the
    /// specified
    /// boot mode.
    ///
    /// For more information, see [Instance launch behavior with Amazon EC2
    /// boot
    /// modes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-boot.html) in
    /// the *Amazon EC2 User Guide*.
    boot_mode: ?BootModeValues = null,

    /// A description for your AMI.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Set to `true` to enable enhanced networking with ENA for the AMI and any
    /// instances that you launch from the AMI.
    ///
    /// This option is supported only for HVM AMIs. Specifying this option with a PV
    /// AMI can make
    /// instances launched from the AMI unreachable.
    ena_support: ?bool = null,

    /// The full path to your AMI manifest in Amazon S3 storage. The specified
    /// bucket must have the
    /// `aws-exec-read` canned access control list (ACL) to ensure that it can be
    /// accessed by Amazon EC2. For more information, see [Canned
    /// ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) in the
    /// *Amazon S3 Service Developer Guide*.
    image_location: ?[]const u8 = null,

    /// Set to `v2.0` to indicate that IMDSv2 is specified in the AMI. Instances
    /// launched from this AMI will have `HttpTokens` automatically set to
    /// `required` so that, by default, the instance requires that IMDSv2 is used
    /// when
    /// requesting instance metadata. In addition, `HttpPutResponseHopLimit` is set
    /// to
    /// `2`. For more information, see [Configure the
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-new-instances.html#configure-IMDS-new-instances-ami-configuration) in the *Amazon EC2 User Guide*.
    ///
    /// If you set the value to `v2.0`, make sure that your AMI software can support
    /// IMDSv2.
    imds_support: ?ImdsSupportValues = null,

    /// The ID of the kernel.
    kernel_id: ?[]const u8 = null,

    /// A name for your AMI.
    ///
    /// Constraints: 3-128 alphanumeric characters, parentheses (()), square
    /// brackets ([]), spaces
    /// ( ), periods (.), slashes (/), dashes (-), single quotes ('), at-signs (@),
    /// or
    /// underscores(_)
    name: []const u8,

    /// The ID of the RAM disk.
    ramdisk_id: ?[]const u8 = null,

    /// The device name of the root device volume (for example, `/dev/sda1`).
    root_device_name: ?[]const u8 = null,

    /// Set to `simple` to enable enhanced networking with the Intel 82599 Virtual
    /// Function interface for the AMI and any instances that you launch from the
    /// AMI.
    ///
    /// There is no way to disable `sriovNetSupport` at this time.
    ///
    /// This option is supported only for HVM AMIs. Specifying this option with a PV
    /// AMI can make
    /// instances launched from the AMI unreachable.
    sriov_net_support: ?[]const u8 = null,

    /// The tags to apply to the AMI.
    ///
    /// To tag the AMI, the value for `ResourceType` must be `image`. If you
    /// specify another value for `ResourceType`, the request fails.
    ///
    /// To tag an AMI after it has been registered, see
    /// [CreateTags](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html).
    tag_specifications: ?[]const TagSpecification = null,

    /// Set to `v2.0` to enable Trusted Platform Module (TPM) support. For more
    /// information, see
    /// [NitroTPM](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nitrotpm.html) in the *Amazon EC2 User Guide*.
    tpm_support: ?TpmSupportValues = null,

    /// Base64 representation of the non-volatile UEFI variable store. To retrieve
    /// the UEFI data,
    /// use the
    /// [GetInstanceUefiData](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_GetInstanceUefiData) command. You can inspect and modify the UEFI data by using the
    /// [python-uefivars tool](https://github.com/awslabs/python-uefivars) on
    /// GitHub. For more information, see [UEFI Secure Boot for Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/uefi-secure-boot.html) in the *Amazon EC2 User Guide*.
    uefi_data: ?[]const u8 = null,

    /// The type of virtualization (`hvm` | `paravirtual`).
    ///
    /// Default: `paravirtual`
    virtualization_type: ?[]const u8 = null,
};

pub const RegisterImageOutput = struct {
    /// The ID of the newly registered AMI.
    image_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *RegisterImageOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RegisterImageInput, options: Options) !RegisterImageOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: RegisterImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RegisterImage&Version=2016-11-15");
    if (input.architecture) |v| {
        try body_buf.appendSlice(alloc, "&Architecture=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.billing_products) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BillingProduct.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.block_device_mappings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.DeviceName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.ebs) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.AvailabilityZone=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.availability_zone) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.AvailabilityZoneId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.availability_zone_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.DeleteOnTermination=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.delete_on_termination) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.EbsCardIndex=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.ebs_card_index) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.Encrypted=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.encrypted) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.Iops=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.iops) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.KmsKeyId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.kms_key_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.OutpostArn=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.outpost_arn) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.SnapshotId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.snapshot_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.Throughput=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.throughput) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.VolumeInitializationRate=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_initialization_rate) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.VolumeSize=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_size) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.VolumeType=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_type) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.NoDevice=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.no_device) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.VirtualName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.virtual_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.boot_mode) |v| {
        try body_buf.appendSlice(alloc, "&BootMode=");
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
    if (input.ena_support) |v| {
        try body_buf.appendSlice(alloc, "&EnaSupport=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.image_location) |v| {
        try body_buf.appendSlice(alloc, "&ImageLocation=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.imds_support) |v| {
        try body_buf.appendSlice(alloc, "&ImdsSupport=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.kernel_id) |v| {
        try body_buf.appendSlice(alloc, "&KernelId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&Name=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.name);
    if (input.ramdisk_id) |v| {
        try body_buf.appendSlice(alloc, "&RamdiskId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.root_device_name) |v| {
        try body_buf.appendSlice(alloc, "&RootDeviceName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.sriov_net_support) |v| {
        try body_buf.appendSlice(alloc, "&SriovNetSupport=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.tpm_support) |v| {
        try body_buf.appendSlice(alloc, "&TpmSupport=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.uefi_data) |v| {
        try body_buf.appendSlice(alloc, "&UefiData=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.virtualization_type) |v| {
        try body_buf.appendSlice(alloc, "&VirtualizationType=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RegisterImageOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: RegisterImageOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "imageId")) {
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
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
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);


    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
