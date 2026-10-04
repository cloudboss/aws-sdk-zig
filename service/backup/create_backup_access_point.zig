const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessPointStatus = @import("access_point_status.zig").AccessPointStatus;

pub const CreateBackupAccessPointInput = struct {
    /// Metadata for the backup access point. For continuous (point-in-time)
    /// recovery points, you must include an
    /// `AccessPointInTime` timestamp (in format `2021-11-27T03:30:27Z`). The access
    /// point
    /// provides access to the content present in the backup at that specific time.
    /// You can specify any time
    /// within the continuous backup's retention period, up to the latest restorable
    /// time. For snapshot recovery
    /// points, do not include `AccessPointInTime`.
    access_point_metadata: ?[]const aws.map.StringMapEntry = null,

    /// An optional resource-based policy, in JSON format, to apply to the
    /// underlying Amazon S3 access
    /// point. The policy controls how backup data can be accessed through the
    /// access point. If you do not specify
    /// a policy, access is governed by the caller's IAM permissions. For more
    /// information, see [Configuring IAM policies
    /// for using access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-policies.html) in the *Amazon S3 User Guide*.
    access_point_policy: ?[]const u8 = null,

    /// The name of the backup access point. This name is shared with the Amazon S3
    /// access point namespace.
    /// It must be unique within your account and Region and cannot conflict with an
    /// existing Amazon S3 access
    /// point. For more information about access point naming, see [Access points
    /// naming rules, restrictions, and
    /// limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-restrictions-limitations-naming-rules.html) in the *Amazon S3 User
    /// Guide*.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the recovery point for which to create the
    /// backup access point. The
    /// recovery point must be an Amazon S3 recovery point in the `AVAILABLE`,
    /// `STOPPED`,
    /// or `COMPLETED` state.
    recovery_point_arn: []const u8,

    /// The tags to assign to the backup access point.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .access_point_metadata = "AccessPointMetadata",
        .access_point_policy = "AccessPointPolicy",
        .name = "Name",
        .recovery_point_arn = "RecoveryPointArn",
        .tags = "Tags",
    };
};

pub const CreateBackupAccessPointOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the created backup
    /// access point.
    access_point_arn: []const u8,

    /// The current status of the backup access point. A newly created backup access
    /// point begins in the
    /// `CREATING` state and becomes usable when it reaches `AVAILABLE`.
    status: AccessPointStatus,

    pub const json_field_names = .{
        .access_point_arn = "AccessPointArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBackupAccessPointInput, options: CallOptions) !CreateBackupAccessPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBackupAccessPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/backup-access-point/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.access_point_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccessPointMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.access_point_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccessPointPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RecoveryPointArn\":");
    try aws.json.writeValue(@TypeOf(input.recovery_point_arn), input.recovery_point_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBackupAccessPointOutput {
    const result: CreateBackupAccessPointOutput = try aws.json.parseJsonObject(
        CreateBackupAccessPointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
