const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ClientData = @import("client_data.zig").ClientData;
const SnapshotDiskContainer = @import("snapshot_disk_container.zig").SnapshotDiskContainer;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const SnapshotTaskDetail = @import("snapshot_task_detail.zig").SnapshotTaskDetail;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportSnapshotInput, options: CallOptions) !ImportSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ImportSnapshot&Version=2016-11-15");
    if (input.client_data) |v| {
        if (v.comment) |sv| {
            try body_buf.appendSlice(allocator, "&ClientData.Comment=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.upload_end) |sv| {
            try body_buf.appendSlice(allocator, "&ClientData.UploadEnd=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.upload_size) |sv| {
            try body_buf.appendSlice(allocator, "&ClientData.UploadSize=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.upload_start) |sv| {
            try body_buf.appendSlice(allocator, "&ClientData.UploadStart=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.disk_container) |v| {
        if (v.description) |sv| {
            try body_buf.appendSlice(allocator, "&DiskContainer.Description=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.format) |sv| {
            try body_buf.appendSlice(allocator, "&DiskContainer.Format=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.url) |sv| {
            try body_buf.appendSlice(allocator, "&DiskContainer.Url=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.user_bucket) |sv| {
            if (sv.s3_bucket) |sv2| {
                try body_buf.appendSlice(allocator, "&DiskContainer.UserBucket.S3Bucket=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.s3_key) |sv2| {
                try body_buf.appendSlice(allocator, "&DiskContainer.UserBucket.S3Key=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.encrypted) |v| {
        try body_buf.appendSlice(allocator, "&Encrypted=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.role_name) |v| {
        try body_buf.appendSlice(allocator, "&RoleName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportSnapshotOutput {
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
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "importTaskId")) {
                    result.import_task_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "snapshotTaskDetail")) {
                    result.snapshot_task_detail = try serde.deserializeSnapshotTaskDetail(allocator, &reader);
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
