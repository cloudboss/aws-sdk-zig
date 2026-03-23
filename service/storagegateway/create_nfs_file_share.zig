const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CacheAttributes = @import("cache_attributes.zig").CacheAttributes;
const EncryptionType = @import("encryption_type.zig").EncryptionType;
const NFSFileShareDefaults = @import("nfs_file_share_defaults.zig").NFSFileShareDefaults;
const ObjectACL = @import("object_acl.zig").ObjectACL;
const Tag = @import("tag.zig").Tag;

pub const CreateNFSFileShareInput = struct {
    /// The Amazon Resource Name (ARN) of the storage used for audit logs.
    audit_destination_arn: ?[]const u8 = null,

    /// Specifies the Region of the S3 bucket where the NFS file share stores files.
    ///
    /// This parameter is required for NFS file shares that connect to Amazon S3
    /// through a VPC endpoint, a VPC access point, or an access point alias that
    /// points to a
    /// VPC access point.
    bucket_region: ?[]const u8 = null,

    /// Specifies refresh cache information for the file share.
    cache_attributes: ?CacheAttributes = null,

    /// The list of clients that are allowed to access the S3 File Gateway. The list
    /// must
    /// contain either valid IPv4/IPv6 addresses or valid CIDR blocks.
    client_list: ?[]const []const u8 = null,

    /// A unique string value that you supply that is used by S3 File Gateway to
    /// ensure
    /// idempotent file share creation.
    client_token: []const u8,

    /// The default storage class for objects put into an Amazon S3 bucket by the S3
    /// File Gateway. The default value is `S3_STANDARD`. Optional.
    ///
    /// Valid Values: `S3_STANDARD` | `S3_INTELLIGENT_TIERING` |
    /// `S3_STANDARD_IA` | `S3_ONEZONE_IA`
    default_storage_class: ?[]const u8 = null,

    /// A value that specifies the type of server-side encryption that the file
    /// share will use
    /// for the data that it stores in Amazon S3.
    ///
    /// We recommend using `EncryptionType` instead of `KMSEncrypted`
    /// to set the file share encryption method. You do not need to provide values
    /// for both
    /// parameters.
    ///
    /// If values for both parameters exist in the same request, then the specified
    /// encryption methods must not conflict. For example, if `EncryptionType` is
    /// `SseS3`, then `KMSEncrypted` must be `false`. If
    /// `EncryptionType` is `SseKms` or `DsseKms`, then
    /// `KMSEncrypted` must be `true`.
    encryption_type: ?EncryptionType = null,

    /// The name of the file share. Optional.
    ///
    /// `FileShareName` must be set if an S3 prefix name is set in
    /// `LocationARN`, or if an access point or access point alias is used.
    ///
    /// A valid NFS file share name can only contain the following characters:
    /// `a`-`z`, `A`-`Z`,
    /// `0`-`9`, `-`, `.`, and
    /// `_`.
    file_share_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the S3 File Gateway on which you want to
    /// create a file
    /// share.
    gateway_arn: []const u8,

    /// A value that enables guessing of the MIME type for uploaded objects based on
    /// file
    /// extensions. Set this value to `true` to enable MIME type guessing, otherwise
    /// set
    /// to `false`. The default value is `true`.
    ///
    /// Valid Values: `true` | `false`
    guess_mime_type_enabled: ?bool = null,

    /// Optional. Set to `true` to use Amazon S3 server-side encryption with
    /// your own KMS key (SSE-KMS), or `false` to use a key managed by
    /// Amazon S3 (SSE-S3). To use dual-layer encryption (DSSE-KMS), set the
    /// `EncryptionType` parameter instead.
    ///
    /// We recommend using `EncryptionType` instead of `KMSEncrypted`
    /// to set the file share encryption method. You do not need to provide values
    /// for both
    /// parameters.
    ///
    /// If values for both parameters exist in the same request, then the specified
    /// encryption methods must not conflict. For example, if `EncryptionType` is
    /// `SseS3`, then `KMSEncrypted` must be `false`. If
    /// `EncryptionType` is `SseKms` or `DsseKms`, then
    /// `KMSEncrypted` must be `true`.
    ///
    /// Valid Values: `true` | `false`
    kms_encrypted: ?bool = null,

    /// Optional. The Amazon Resource Name (ARN) of a symmetric customer master key
    /// (CMK) used
    /// for Amazon S3 server-side encryption. Storage Gateway does not support
    /// asymmetric
    /// CMKs. This value must be set if `KMSEncrypted` is `true`, or if
    /// `EncryptionType` is `SseKms` or `DsseKms`.
    kms_key: ?[]const u8 = null,

    /// A custom ARN for the backend storage used for storing data for file shares.
    /// It includes
    /// a resource ARN with an optional prefix concatenation. The prefix must end
    /// with a forward
    /// slash (/).
    ///
    /// You can specify LocationARN as a bucket ARN, access point ARN or access
    /// point alias,
    /// as shown in the following examples.
    ///
    /// Bucket ARN:
    ///
    /// `arn:aws:s3:::amzn-s3-demo-bucket/prefix/`
    ///
    /// Access point ARN:
    ///
    /// `arn:aws:s3:region:account-id:accesspoint/access-point-name/prefix/`
    ///
    /// If you specify an access point, the bucket policy must be configured to
    /// delegate
    /// access control to the access point. For information, see [Delegating access
    /// control to access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-policies.html#access-points-delegating-control) in the *Amazon S3 User Guide*.
    ///
    /// Access point alias:
    ///
    /// `test-ap-ab123cdef4gehijklmn5opqrstuvuse1a-s3alias`
    location_arn: []const u8,

    /// File share default values. Optional.
    nfs_file_share_defaults: ?NFSFileShareDefaults = null,

    /// The notification policy of the file share. `SettlingTimeInSeconds` controls
    /// the number of seconds to wait after the last point in time a client wrote to
    /// a file before
    /// generating an `ObjectUploaded` notification. Because clients can make many
    /// small
    /// writes to files, it's best to set this parameter for as long as possible to
    /// avoid
    /// generating multiple notifications for the same file in a small time period.
    ///
    /// `SettlingTimeInSeconds` has no effect on the timing of the object
    /// uploading to Amazon S3, only the timing of the notification.
    ///
    /// This setting is not meant to specify an exact time at which the notification
    /// will be
    /// sent. In some cases, the gateway might require more than the specified delay
    /// time to
    /// generate and send notifications.
    ///
    /// The following example sets `NotificationPolicy` on with
    /// `SettlingTimeInSeconds` set to 60.
    ///
    /// `{\"Upload\": {\"SettlingTimeInSeconds\": 60}}`
    ///
    /// The following example sets `NotificationPolicy` off.
    ///
    /// `{}`
    notification_policy: ?[]const u8 = null,

    /// A value that sets the access control list (ACL) permission for objects in
    /// the S3 bucket
    /// that a S3 File Gateway puts objects into. The default value is `private`.
    object_acl: ?ObjectACL = null,

    /// A value that sets the write status of a file share. Set this value to `true`
    /// to set the write status to read-only, otherwise set to `false`.
    ///
    /// Valid Values: `true` | `false`
    read_only: ?bool = null,

    /// A value that sets who pays the cost of the request and the cost associated
    /// with data
    /// download from the S3 bucket. If this value is set to `true`, the requester
    /// pays
    /// the costs; otherwise, the S3 bucket owner pays. However, the S3 bucket owner
    /// always pays
    /// the cost of storing data.
    ///
    /// `RequesterPays` is a configuration for the S3 bucket that backs the file
    /// share, so make sure that the configuration on the file share is the same as
    /// the S3
    /// bucket configuration.
    ///
    /// Valid Values: `true` | `false`
    requester_pays: ?bool = null,

    /// The ARN of the Identity and Access Management (IAM) role that an S3 File
    /// Gateway assumes when it
    /// accesses the underlying storage.
    role: []const u8,

    /// A value that maps a user to anonymous user.
    ///
    /// Valid values are the following:
    ///
    /// * `RootSquash`: Only root is mapped to anonymous user.
    ///
    /// * `NoSquash`: No one is mapped to anonymous user.
    ///
    /// * `AllSquash`: Everyone is mapped to anonymous user.
    squash: ?[]const u8 = null,

    /// A list of up to 50 tags that can be assigned to the NFS file share. Each tag
    /// is a
    /// key-value pair.
    ///
    /// Valid characters for key and value are letters, spaces, and numbers
    /// representable in
    /// UTF-8 format, and the following special characters: + - = . _ : / @. The
    /// maximum length
    /// of a tag's key is 128 characters, and the maximum length for a tag's value
    /// is
    /// 256.
    tags: ?[]const Tag = null,

    /// Specifies the DNS name for the VPC endpoint that the NFS file share uses to
    /// connect to
    /// Amazon S3.
    ///
    /// This parameter is required for NFS file shares that connect to Amazon S3
    /// through a VPC endpoint, a VPC access point, or an access point alias that
    /// points to a
    /// VPC access point.
    vpc_endpoint_dns_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .audit_destination_arn = "AuditDestinationARN",
        .bucket_region = "BucketRegion",
        .cache_attributes = "CacheAttributes",
        .client_list = "ClientList",
        .client_token = "ClientToken",
        .default_storage_class = "DefaultStorageClass",
        .encryption_type = "EncryptionType",
        .file_share_name = "FileShareName",
        .gateway_arn = "GatewayARN",
        .guess_mime_type_enabled = "GuessMIMETypeEnabled",
        .kms_encrypted = "KMSEncrypted",
        .kms_key = "KMSKey",
        .location_arn = "LocationARN",
        .nfs_file_share_defaults = "NFSFileShareDefaults",
        .notification_policy = "NotificationPolicy",
        .object_acl = "ObjectACL",
        .read_only = "ReadOnly",
        .requester_pays = "RequesterPays",
        .role = "Role",
        .squash = "Squash",
        .tags = "Tags",
        .vpc_endpoint_dns_name = "VPCEndpointDNSName",
    };
};

pub const CreateNFSFileShareOutput = struct {
    /// The Amazon Resource Name (ARN) of the newly created file share.
    file_share_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_share_arn = "FileShareARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNFSFileShareInput, options: CallOptions) !CreateNFSFileShareOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNFSFileShareInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.CreateNFSFileShare");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNFSFileShareOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateNFSFileShareOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
