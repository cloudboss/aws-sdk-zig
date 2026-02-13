const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExportToS3TaskSpecification = @import("export_to_s_3_task_specification.zig").ExportToS3TaskSpecification;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const ExportEnvironment = @import("export_environment.zig").ExportEnvironment;
const ExportTask = @import("export_task.zig").ExportTask;
const serde = @import("serde.zig");

/// Exports a running or stopped instance to an Amazon S3 bucket.
///
/// For information about the prerequisites for your Amazon S3 bucket, supported
/// operating systems,
/// image formats, and known limitations for the types of instances you can
/// export, see [Exporting an instance as a VM Using VM
/// Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport.html) in the *VM Import/Export User Guide*.
pub const CreateInstanceExportTaskInput = struct {
    /// A description for the conversion task or the resource being exported. The
    /// maximum length is 255 characters.
    description: ?[]const u8 = null,

    /// The format and location for an export instance task.
    export_to_s_3_task: ExportToS3TaskSpecification,

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateInstanceExportTaskOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateInstanceExportTaskInput, options: Options) !CreateInstanceExportTaskOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateInstanceExportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateInstanceExportTask&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.export_to_s_3_task.container_format) |sv| {
        try body_buf.appendSlice(alloc, "&ExportToS3Task.ContainerFormat=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.export_to_s_3_task.disk_image_format) |sv| {
        try body_buf.appendSlice(alloc, "&ExportToS3Task.DiskImageFormat=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.export_to_s_3_task.s_3_bucket) |sv| {
        try body_buf.appendSlice(alloc, "&ExportToS3Task.S3Bucket=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.export_to_s_3_task.s_3_prefix) |sv| {
        try body_buf.appendSlice(alloc, "&ExportToS3Task.S3Prefix=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_id);
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&TargetEnvironment=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.target_environment));

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateInstanceExportTaskOutput {
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
                    result.export_task = try serde.deserializeExportTask(&reader, alloc);
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
