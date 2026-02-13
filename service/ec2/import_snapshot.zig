const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClientData = @import("client_data.zig").ClientData;
const SnapshotDiskContainer = @import("snapshot_disk_container.zig").SnapshotDiskContainer;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const SnapshotTaskDetail = @import("snapshot_task_detail.zig").SnapshotTaskDetail;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

/// Imports a disk into an EBS snapshot.
///
/// For more information, see [Importing a disk as a snapshot using VM
/// Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-import-snapshot.html) in the
/// *VM Import/Export User Guide*.
pub const ImportSnapshotInput = struct {
    /// The client-specific data.
    client_data: ?ClientData = null,

    /// Token to enable idempotency for VM import requests.
    client_token: ?[]const u8 = null,

    /// The description string for the import snapshot task.
    description: ?[]const u8 = null,

    /// Information about the disk container.
    disk_container: ?SnapshotDiskContainer = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Specifies whether the destination snapshot of the imported image should be
    /// encrypted. The default KMS key for EBS is
    /// used unless you specify a non-default KMS key using `KmsKeyId`. For more
    /// information, see [Amazon EBS
    /// Encryption](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    encrypted: ?bool = null,

    /// An identifier for the symmetric KMS key to use when creating the
    /// encrypted snapshot. This parameter is only required if you want to use a
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
    /// The specified KMS key must exist in the Region that the snapshot is being
    /// copied to.
    ///
    /// Amazon EBS does not support asymmetric KMS keys.
    kms_key_id: ?[]const u8 = null,

    /// The name of the role to use when not using the default role, 'vmimport'.
    role_name: ?[]const u8 = null,

    /// The tags to apply to the import snapshot task during creation.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const ImportSnapshotOutput = struct {
    /// A description of the import snapshot task.
    description: ?[]const u8 = null,

    /// The ID of the import snapshot task.
    import_task_id: ?[]const u8 = null,

    /// Information about the import snapshot task.
    snapshot_task_detail: ?SnapshotTaskDetail = null,

    /// Any tags assigned to the import snapshot task.
    tags: ?[]const Tag = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ImportSnapshotOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ImportSnapshotInput, options: Options) !ImportSnapshotOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ImportSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ImportSnapshot&Version=2016-11-15");
    if (input.client_data) |v| {
        if (v.comment) |sv| {
            try body_buf.appendSlice(alloc, "&ClientData.Comment=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.upload_end) |sv| {
            try body_buf.appendSlice(alloc, "&ClientData.UploadEnd=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.upload_size) |sv| {
            try body_buf.appendSlice(alloc, "&ClientData.UploadSize=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.upload_start) |sv| {
            try body_buf.appendSlice(alloc, "&ClientData.UploadStart=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.disk_container) |v| {
        if (v.description) |sv| {
            try body_buf.appendSlice(alloc, "&DiskContainer.Description=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.format) |sv| {
            try body_buf.appendSlice(alloc, "&DiskContainer.Format=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.url) |sv| {
            try body_buf.appendSlice(alloc, "&DiskContainer.Url=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.user_bucket) |sv| {
            if (sv.s_3_bucket) |sv2| {
                try body_buf.appendSlice(alloc, "&DiskContainer.UserBucket.S3Bucket=");
                try appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.s_3_key) |sv2| {
                try body_buf.appendSlice(alloc, "&DiskContainer.UserBucket.S3Key=");
                try appendUrlEncoded(alloc, &body_buf, sv2);
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.encrypted) |v| {
        try body_buf.appendSlice(alloc, "&Encrypted=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(alloc, "&KmsKeyId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.role_name) |v| {
        try body_buf.appendSlice(alloc, "&RoleName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
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
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ImportSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ImportSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "importTaskId")) {
                    result.import_task_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "snapshotTaskDetail")) {
                    result.snapshot_task_detail = try serde.deserializeSnapshotTaskDetail(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "tagSet")) {
                    result.tags = try serde.deserializeTagList(&reader, alloc, "item");
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
