const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

pub const CreateFileSystemInput = struct {
    /// Set to true to acknowledge and accept any warnings about the bucket
    /// configuration. If not specified, the operation may fail if there are bucket
    /// configuration warnings.
    accept_bucket_warning: ?bool = null,

    /// The Amazon Resource Name (ARN) of the S3 bucket that will be accessible
    /// through the file system. The bucket must exist and be in the same Amazon Web
    /// Services Region as the file system.
    bucket: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure idempotent
    /// creation. Up to 64 ASCII characters are allowed. If you don't specify a
    /// client token, the Amazon Web Services SDK automatically generates one.
    client_token: ?[]const u8 = null,

    /// The ARN, key ID, or alias of the KMS key to use for encryption. If not
    /// specified, the service uses a service-owned key for encryption. You can
    /// specify a KMS key using the following formats: key ID, ARN, key alias, or
    /// key alias ARN. If you use `KmsKeyId`, the file system will be encrypted.
    kms_key_id: ?[]const u8 = null,

    /// An optional prefix within the S3 bucket to scope the file system access. If
    /// specified, the file system provides access only to objects with keys that
    /// begin with this prefix. If not specified, the file system provides access to
    /// the entire bucket.
    prefix: ?[]const u8 = null,

    /// The ARN of the IAM role that grants the S3 Files service permission to read
    /// and write data between the file system and the S3 bucket. This role must
    /// have the necessary permissions to access the specified bucket and prefix.
    role_arn: []const u8,

    /// An array of key-value pairs to apply as tags to the file system resource.
    /// Each tag is a user-defined key-value pair. You can use tags to categorize
    /// and manage your file systems. Each key must be unique for the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .accept_bucket_warning = "acceptBucketWarning",
        .bucket = "bucket",
        .client_token = "clientToken",
        .kms_key_id = "kmsKeyId",
        .prefix = "prefix",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateFileSystemOutput = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket associated with the file
    /// system.
    bucket: ?[]const u8 = null,

    /// The client token used for idempotency.
    client_token: ?[]const u8 = null,

    /// The time when the file system was created, in seconds since
    /// 1970-01-01T00:00:00Z (Unix epoch time).
    creation_time: ?i64 = null,

    /// The ARN for the S3 file system, in the format
    /// `arn:aws:s3files:region:account-id:file-system/file-system-id`.
    file_system_arn: ?[]const u8 = null,

    /// The ID of the file system, assigned by S3 Files. This ID is used to
    /// reference the file system in subsequent API calls.
    file_system_id: ?[]const u8 = null,

    /// The ARN or alias of the KMS key used for encryption.
    kms_key_id: ?[]const u8 = null,

    /// The name of the file system, derived from the `Name` tag if present.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the file system owner.
    owner_id: ?[]const u8 = null,

    /// The prefix within the S3 bucket that scopes the file system access.
    prefix: ?[]const u8 = null,

    /// The ARN of the IAM role used for S3 access.
    role_arn: ?[]const u8 = null,

    /// The lifecycle state of the file system. Valid values are: `AVAILABLE` (the
    /// file system is available for use), `CREATING` (the file system is being
    /// created), `DELETING` (the file system is being deleted), `DELETED` (the file
    /// system has been deleted), `ERROR` (the file system is in an error state), or
    /// `UPDATING` (the file system is being updated).
    status: ?LifeCycleState = null,

    /// Additional information about the file system status. This field provides
    /// more details when the status is `ERROR`, or during state transitions.
    status_message: ?[]const u8 = null,

    /// The tags associated with the file system.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .client_token = "clientToken",
        .creation_time = "creationTime",
        .file_system_arn = "fileSystemArn",
        .file_system_id = "fileSystemId",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .owner_id = "ownerId",
        .prefix = "prefix",
        .role_arn = "roleArn",
        .status = "status",
        .status_message = "statusMessage",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFileSystemInput, options: CallOptions) !CreateFileSystemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3files", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFileSystemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/file-systems";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.accept_bucket_warning) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"acceptBucketWarning\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"bucket\":");
    try aws.json.writeValue(@TypeOf(input.bucket), input.bucket, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prefix) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"prefix\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFileSystemOutput {
    const result: CreateFileSystemOutput = try aws.json.parseJsonObject(
        CreateFileSystemOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
