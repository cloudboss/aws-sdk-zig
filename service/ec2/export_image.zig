const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DiskImageFormat = @import("disk_image_format.zig").DiskImageFormat;
const ExportTaskS3LocationRequest = @import("export_task_s3_location_request.zig").ExportTaskS3LocationRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const ExportTaskS3Location = @import("export_task_s3_location.zig").ExportTaskS3Location;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

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
    s3_export_location: ExportTaskS3LocationRequest,

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
    s3_export_location: ?ExportTaskS3Location = null,

    /// The status of the export image task. The possible values are `active`,
    /// `completed`,
    /// `deleting`, and `deleted`.
    status: ?[]const u8 = null,

    /// The status message for the export image task.
    status_message: ?[]const u8 = null,

    /// Any tags assigned to the export image task.
    tags: ?[]const Tag = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportImageInput, options: CallOptions) !ExportImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ExportImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ExportImage&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DiskImageFormat=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.disk_image_format.wireName());
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&ImageId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.image_id);
    if (input.role_name) |v| {
        try body_buf.appendSlice(allocator, "&RoleName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&S3ExportLocation.S3Bucket=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.s3_export_location.s3_bucket);
    if (input.s3_export_location.s3_prefix) |sv| {
        try body_buf.appendSlice(allocator, "&S3ExportLocation.S3Prefix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportImageOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ExportImageOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "diskImageFormat")) {
                    result.disk_image_format = DiskImageFormat.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "exportImageTaskId")) {
                    result.export_image_task_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "imageId")) {
                    result.image_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "progress")) {
                    result.progress = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "roleName")) {
                    result.role_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "s3ExportLocation")) {
                    result.s3_export_location = try serde.deserializeExportTaskS3Location(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "statusMessage")) {
                    result.status_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "tagSet")) {
                    result.tags = try serde.deserializeTagList(allocator, &reader, "item");
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
