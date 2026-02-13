const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DiskImage = @import("disk_image.zig").DiskImage;
const ImportInstanceLaunchSpecification = @import("import_instance_launch_specification.zig").ImportInstanceLaunchSpecification;
const PlatformValues = @import("platform_values.zig").PlatformValues;
const ConversionTask = @import("conversion_task.zig").ConversionTask;
const serde = @import("serde.zig");

/// **Note:**
///
/// We recommend that you use the [
/// `ImportImage`
/// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportImage.html)
/// API instead. For more information, see [Importing a VM as an image using VM
/// Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html) in the *VM Import/Export User Guide*.
///
/// Creates an import instance task using metadata from the specified disk
/// image.
///
/// This API action supports only single-volume VMs. To import multi-volume VMs,
/// use ImportImage
/// instead.
///
/// For information about the import manifest referenced by this API action, see
/// [VM Import
/// Manifest](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/manifest.html).
///
/// This API action is not supported by the Command Line Interface (CLI).
pub const ImportInstanceInput = struct {
    /// A description for the instance being imported.
    description: ?[]const u8 = null,

    /// The disk image.
    disk_images: ?[]const DiskImage = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The launch specification.
    launch_specification: ?ImportInstanceLaunchSpecification = null,

    /// The instance operating system.
    platform: PlatformValues,
};

pub const ImportInstanceOutput = struct {
    /// Information about the conversion task.
    conversion_task: ?ConversionTask = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ImportInstanceOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ImportInstanceInput, options: Options) !ImportInstanceOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ImportInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ImportInstance&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.disk_images) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImages.member.{d}.Description=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.description) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.image) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImages.member.{d}.Image.Bytes=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv_1.bytes}) catch "");
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImages.member.{d}.Image.Format=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv_1.format));
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImages.member.{d}.Image.ImportManifestUrl=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.import_manifest_url);
                }
            }
            if (item.volume) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImages.member.{d}.Volume.Size=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv_1.size}) catch "");
                }
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.launch_specification) |v| {
        if (v.additional_info) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.AdditionalInfo=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.architecture) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.Architecture=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.group_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.GroupIds.SecurityGroupId.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (v.group_names) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.GroupNames.SecurityGroup.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (v.instance_initiated_shutdown_behavior) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.InstanceInitiatedShutdownBehavior=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.instance_type) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.InstanceType=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.monitoring) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.Monitoring=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.placement) |sv| {
            if (sv.affinity) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.Affinity=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.availability_zone) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.AvailabilityZone=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.availability_zone_id) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.AvailabilityZoneId=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.group_id) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.GroupId=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.group_name) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.GroupName=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.host_id) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.HostId=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.host_resource_group_arn) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.HostResourceGroupArn=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.partition_number) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.PartitionNumber=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
            if (sv.spread_domain) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.SpreadDomain=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.tenancy) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.Tenancy=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
            }
        }
        if (v.private_ip_address) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.PrivateIpAddress=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.subnet_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.SubnetId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.user_data) |sv| {
            if (sv.data) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.UserData.Data=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
        }
    }
    try body_buf.appendSlice(alloc, "&Platform=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.platform));

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ImportInstanceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ImportInstanceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "conversionTask")) {
                    result.conversion_task = try serde.deserializeConversionTask(&reader, alloc);
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
