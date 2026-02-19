const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BootModeValues = @import("boot_mode_values.zig").BootModeValues;
const ClientData = @import("client_data.zig").ClientData;
const ImageDiskContainer = @import("image_disk_container.zig").ImageDiskContainer;
const ImportImageLicenseConfigurationRequest = @import("import_image_license_configuration_request.zig").ImportImageLicenseConfigurationRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const ImportImageLicenseConfigurationResponse = @import("import_image_license_configuration_response.zig").ImportImageLicenseConfigurationResponse;
const SnapshotDetail = @import("snapshot_detail.zig").SnapshotDetail;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const ImportImageInput = struct {
    /// The architecture of the virtual machine.
    ///
    /// Valid values: `i386` | `x86_64`
    architecture: ?[]const u8 = null,

    /// The boot mode of the virtual machine.
    ///
    /// The `uefi-preferred` boot mode isn't supported for importing images. For
    /// more
    /// information, see [Boot
    /// modes](https://docs.aws.amazon.com/vm-import/latest/userguide/prerequisites.html#vmimport-boot-modes) in
    /// the *VM Import/Export User Guide*.
    boot_mode: ?BootModeValues = null,

    /// The client-specific data.
    client_data: ?ClientData = null,

    /// The token to enable idempotency for VM import requests.
    client_token: ?[]const u8 = null,

    /// A description string for the import image task.
    description: ?[]const u8 = null,

    /// Information about the disk containers.
    disk_containers: ?[]const ImageDiskContainer = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Specifies whether the destination AMI of the imported image should be
    /// encrypted. The default KMS key for EBS is used
    /// unless you specify a non-default KMS key using `KmsKeyId`. For more
    /// information, see [Amazon EBS
    /// Encryption](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    encrypted: ?bool = null,

    /// The target hypervisor platform.
    ///
    /// Valid values: `xen`
    hypervisor: ?[]const u8 = null,

    /// An identifier for the symmetric KMS key to use when creating the
    /// encrypted AMI. This parameter is only required if you want to use a
    /// non-default KMS key; if this
    /// parameter is not specified, the default KMS key for EBS is used. If a
    /// `KmsKeyId` is
    /// specified, the `Encrypted` flag must also be set.
    ///
    /// The KMS key identifier may be provided in any of the following formats:
    ///
    /// * Key ID
    ///
    /// * Key alias
    ///
    /// * ARN using key ID. The ID ARN contains the `arn:aws:kms` namespace,
    ///   followed by the Region of the key, the Amazon Web Services account ID of
    ///   the key owner, the `key` namespace, and then the key ID. For example,
    ///   arn:aws:kms:*us-east-1*:*012345678910*:key/*abcd1234-a123-456a-a12b-a123b4cd56ef*.
    ///
    /// * ARN using key alias. The alias ARN contains the `arn:aws:kms` namespace,
    ///   followed by the Region of the key, the Amazon Web Services account ID of
    ///   the key owner, the `alias` namespace, and then the key alias. For example,
    ///   arn:aws:kms:*us-east-1*:*012345678910*:alias/*ExampleAlias*.
    ///
    /// Amazon Web Services parses `KmsKeyId` asynchronously, meaning that the
    /// action you call may appear to complete even
    /// though you provided an invalid identifier. This action will eventually
    /// report failure.
    ///
    /// The specified KMS key must exist in the Region that the AMI is being copied
    /// to.
    ///
    /// Amazon EBS does not support asymmetric KMS keys.
    kms_key_id: ?[]const u8 = null,

    /// The ARNs of the license configurations.
    license_specifications: ?[]const ImportImageLicenseConfigurationRequest = null,

    /// The license type to be used for the Amazon Machine Image (AMI) after
    /// importing.
    ///
    /// Specify `AWS` to replace the source-system license with an Amazon Web
    /// Services
    /// license or `BYOL` to retain the source-system license. Leaving this
    /// parameter
    /// undefined is the same as choosing `AWS` when importing a Windows Server
    /// operating
    /// system, and the same as choosing `BYOL` when importing a Windows client
    /// operating
    /// system (such as Windows 10) or a Linux operating system.
    ///
    /// To use `BYOL`, you must have existing licenses with rights to use these
    /// licenses in a third party
    /// cloud, such as Amazon Web Services. For more information, see
    /// [Prerequisites](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html#prerequisites-image) in the
    /// VM Import/Export User Guide.
    license_type: ?[]const u8 = null,

    /// The operating system of the virtual machine. If you import a VM that is
    /// compatible with
    /// Unified Extensible Firmware Interface (UEFI) using an EBS snapshot, you must
    /// specify a value for
    /// the platform.
    ///
    /// Valid values: `Windows` | `Linux`
    platform: ?[]const u8 = null,

    /// The name of the role to use when not using the default role, 'vmimport'.
    role_name: ?[]const u8 = null,

    /// The tags to apply to the import image task during creation.
    tag_specifications: ?[]const TagSpecification = null,

    /// The usage operation value. For more information, see [Licensing
    /// options](https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#prerequisites) in the *VM Import/Export User Guide*.
    usage_operation: ?[]const u8 = null,
};

pub const ImportImageOutput = struct {
    /// The architecture of the virtual machine.
    architecture: ?[]const u8 = null,

    /// A description of the import task.
    description: ?[]const u8 = null,

    /// Indicates whether the AMI is encrypted.
    encrypted: ?bool = null,

    /// The target hypervisor of the import task.
    hypervisor: ?[]const u8 = null,

    /// The ID of the Amazon Machine Image (AMI) created by the import task.
    image_id: ?[]const u8 = null,

    /// The task ID of the import image task.
    import_task_id: ?[]const u8 = null,

    /// The identifier for the symmetric KMS key that was used to create the
    /// encrypted AMI.
    kms_key_id: ?[]const u8 = null,

    /// The ARNs of the license configurations.
    license_specifications: ?[]const ImportImageLicenseConfigurationResponse = null,

    /// The license type of the virtual machine.
    license_type: ?[]const u8 = null,

    /// The operating system of the virtual machine.
    platform: ?[]const u8 = null,

    /// The progress of the task.
    progress: ?[]const u8 = null,

    /// Information about the snapshots.
    snapshot_details: ?[]const SnapshotDetail = null,

    /// A brief status of the task.
    status: ?[]const u8 = null,

    /// A detailed status message of the import task.
    status_message: ?[]const u8 = null,

    /// Any tags assigned to the import image task.
    tags: ?[]const Tag = null,

    /// The usage operation value.
    usage_operation: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ImportImageOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ImportImageInput, options: Options) !ImportImageOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ImportImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ImportImage&Version=2016-11-15");
    if (input.architecture) |v| {
        try body_buf.appendSlice(alloc, "&Architecture=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.boot_mode) |v| {
        try body_buf.appendSlice(alloc, "&BootMode=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.client_data) |v| {
        if (v.comment) |sv| {
            try body_buf.appendSlice(alloc, "&ClientData.Comment=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.upload_end) |sv| {
            try body_buf.appendSlice(alloc, "&ClientData.UploadEnd=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.upload_size) |sv| {
            try body_buf.appendSlice(alloc, "&ClientData.UploadSize=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.upload_start) |sv| {
            try body_buf.appendSlice(alloc, "&ClientData.UploadStart=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.disk_containers) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskContainer.item.{d}.Description=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.description) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskContainer.item.{d}.DeviceName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskContainer.item.{d}.Format=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.format) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskContainer.item.{d}.SnapshotId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.snapshot_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskContainer.item.{d}.Url=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.url) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.user_bucket) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskContainer.item.{d}.UserBucket.S3Bucket=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.s3_bucket) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskContainer.item.{d}.UserBucket.S3Key=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.s3_key) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.encrypted) |v| {
        try body_buf.appendSlice(alloc, "&Encrypted=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.hypervisor) |v| {
        try body_buf.appendSlice(alloc, "&Hypervisor=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(alloc, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.license_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LicenseSpecifications.item.{d}.LicenseConfigurationArn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.license_configuration_arn) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.license_type) |v| {
        try body_buf.appendSlice(alloc, "&LicenseType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.platform) |v| {
        try body_buf.appendSlice(alloc, "&Platform=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.role_name) |v| {
        try body_buf.appendSlice(alloc, "&RoleName=");
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
    if (input.usage_operation) |v| {
        try body_buf.appendSlice(alloc, "&UsageOperation=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ImportImageOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ImportImageOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "architecture")) {
                    result.architecture = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "hypervisor")) {
                    result.hypervisor = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "imageId")) {
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "importTaskId")) {
                    result.import_task_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "kmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "licenseSpecifications")) {
                    result.license_specifications = try serde.deserializeImportImageLicenseSpecificationListResponse(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "licenseType")) {
                    result.license_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "platform")) {
                    result.platform = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "progress")) {
                    result.progress = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "snapshotDetailSet")) {
                    result.snapshot_details = try serde.deserializeSnapshotDetailList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "statusMessage")) {
                    result.status_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "tagSet")) {
                    result.tags = try serde.deserializeTagList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "usageOperation")) {
                    result.usage_operation = try alloc.dupe(u8, try reader.readElementText());
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
