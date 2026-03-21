const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ExportToS3TaskSpecification = @import("export_to_s3_task_specification.zig").ExportToS3TaskSpecification;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const ExportEnvironment = @import("export_environment.zig").ExportEnvironment;
const ExportTask = @import("export_task.zig").ExportTask;
const serde = @import("serde.zig");

pub const CreateInstanceExportTaskInput = struct {
    /// A description for the conversion task or the resource being exported. The
    /// maximum length is 255 characters.
    description: ?[]const u8 = null,

    /// The format and location for an export instance task.
    export_to_s3_task: ExportToS3TaskSpecification,

    /// The ID of the instance.
    instance_id: []const u8,

    /// The tags to apply to the export instance task during creation.
    tag_specifications: ?[]const TagSpecification = null,

    /// The target virtualization environment.
    target_environment: ExportEnvironment,
};

pub const CreateInstanceExportTaskOutput = struct {
    /// Information about the export instance task.
    export_task: ?ExportTask = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInstanceExportTaskInput, options: CallOptions) !CreateInstanceExportTaskOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInstanceExportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateInstanceExportTask&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.export_to_s3_task.container_format) |sv| {
        try body_buf.appendSlice(allocator, "&ExportToS3.ContainerFormat=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.export_to_s3_task.disk_image_format) |sv| {
        try body_buf.appendSlice(allocator, "&ExportToS3.DiskImageFormat=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.export_to_s3_task.s3_bucket) |sv| {
        try body_buf.appendSlice(allocator, "&ExportToS3.S3Bucket=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.export_to_s3_task.s3_prefix) |sv| {
        try body_buf.appendSlice(allocator, "&ExportToS3.S3Prefix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    try body_buf.appendSlice(allocator, "&InstanceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.instance_id);
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
    try body_buf.appendSlice(allocator, "&TargetEnvironment=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_environment.wireName());

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInstanceExportTaskOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateInstanceExportTaskOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "exportTask")) {
                    result.export_task = try serde.deserializeExportTask(allocator, &reader);
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
