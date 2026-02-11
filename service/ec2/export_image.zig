const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DiskImageFormat = @import("disk_image_format.zig").DiskImageFormat;
const ExportTaskS3LocationRequest = @import("export_task_s_3_location_request.zig").ExportTaskS3LocationRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const ExportTaskS3Location = @import("export_task_s_3_location.zig").ExportTaskS3Location;
const Tag = @import("tag.zig").Tag;

/// Exports an Amazon Machine Image (AMI) to a VM file. For more information,
/// see [Exporting a VM
/// directly from an Amazon Machine Image
/// (AMI)](https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport_image.html) in the
/// *VM Import/Export User Guide*.
pub const ExportImageInput = struct {
    /// Token to enable idempotency for export image requests.
    client_token: ?[]const u8 = null,

    /// A description of the image being exported. The maximum length is 255
    /// characters.
    description: ?[]const u8 = null,

    /// The disk image format.
    disk_image_format: DiskImageFormat,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the image.
    image_id: []const u8,

    /// The name of the role that grants VM Import/Export permission to export
    /// images to your Amazon
    /// S3 bucket. If this parameter is not specified, the default role is named
    /// 'vmimport'.
    role_name: ?[]const u8 = null,

    /// The Amazon S3 bucket for the destination image. The destination bucket must
    /// exist.
    s_3_export_location: ExportTaskS3LocationRequest,

    /// The tags to apply to the export image task during creation.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const ExportImageOutput = struct {
    /// A description of the image being exported.
    description: ?[]const u8 = null,

    /// The disk image format for the exported image.
    disk_image_format: ?DiskImageFormat = null,

    /// The ID of the export image task.
    export_image_task_id: ?[]const u8 = null,

    /// The ID of the image.
    image_id: ?[]const u8 = null,

    /// The percent complete of the export image task.
    progress: ?[]const u8 = null,

    /// The name of the role that grants VM Import/Export permission to export
    /// images to your Amazon
    /// S3 bucket.
    role_name: ?[]const u8 = null,

    /// Information about the destination Amazon S3 bucket.
    s_3_export_location: ?ExportTaskS3Location = null,

    /// The status of the export image task. The possible values are `active`,
    /// `completed`,
    /// `deleting`, and `deleted`.
    status: ?[]const u8 = null,

    /// The status message for the export image task.
    status_message: ?[]const u8 = null,

    /// Any tags assigned to the export image task.
    tags: ?[]const Tag = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ExportImageOutput) void {
        if (self.description) |v| {
            self.allocator.free(v);
        }
        if (self.export_image_task_id) |v| {
            self.allocator.free(v);
        }
        if (self.image_id) |v| {
            self.allocator.free(v);
        }
        if (self.progress) |v| {
            self.allocator.free(v);
        }
        if (self.role_name) |v| {
            self.allocator.free(v);
        }
        if (self.status) |v| {
            self.allocator.free(v);
        }
        if (self.status_message) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ExportImageInput, options: Options) !ExportImageOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ExportImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ExportImage&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&DiskImageFormat=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.disk_image_format));
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ImageId=");
    try appendUrlEncoded(alloc, &body_buf, input.image_id);
    if (input.role_name) |v| {
        try body_buf.appendSlice(alloc, "&RoleName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&S3ExportLocation.S3Bucket=");
    try appendUrlEncoded(alloc, &body_buf, input.s_3_export_location.s_3_bucket);
    if (input.s_3_export_location.s_3_prefix) |sv| {
        try body_buf.appendSlice(alloc, "&S3ExportLocation.S3Prefix=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ExportImageOutput {
    _ = status;
    _ = headers;
    var result: ExportImageOutput = .{ .allocator = alloc };
    if (findElement(body, "description")) |content| {
        result.description = try alloc.dupe(u8, content);
    }
    if (findElement(body, "exportImageTaskId")) |content| {
        result.export_image_task_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "imageId")) |content| {
        result.image_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "progress")) |content| {
        result.progress = try alloc.dupe(u8, content);
    }
    if (findElement(body, "roleName")) |content| {
        result.role_name = try alloc.dupe(u8, content);
    }
    if (findElement(body, "status")) |content| {
        result.status = try alloc.dupe(u8, content);
    }
    if (findElement(body, "statusMessage")) |content| {
        result.status_message = try alloc.dupe(u8, content);
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
