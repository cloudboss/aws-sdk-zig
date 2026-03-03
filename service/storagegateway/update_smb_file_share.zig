const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CacheAttributes = @import("cache_attributes.zig").CacheAttributes;
const CaseSensitivity = @import("case_sensitivity.zig").CaseSensitivity;
const EncryptionType = @import("encryption_type.zig").EncryptionType;
const ObjectACL = @import("object_acl.zig").ObjectACL;

pub const UpdateSMBFileShareInput = struct {
    /// The files and folders on this share will only be visible to users with read
    /// access.
    access_based_enumeration: ?bool = null,

    /// A list of users or groups in the Active Directory that have administrator
    /// rights to the
    /// file share. A group must be prefixed with the @ character. Acceptable
    /// formats include:
    /// `DOMAIN\User1`, `user1`, `@group1`, and
    /// `@DOMAIN\group1`. Can only be set if Authentication is set to
    /// `ActiveDirectory`.
    admin_user_list: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the storage used for audit logs.
    audit_destination_arn: ?[]const u8 = null,

    /// Specifies refresh cache information for the file share.
    cache_attributes: ?CacheAttributes = null,

    /// The case of an object name in an Amazon S3 bucket. For
    /// `ClientSpecified`, the client determines the case sensitivity. For
    /// `CaseSensitive`, the gateway determines the case sensitivity. The default
    /// value is `ClientSpecified`.
    case_sensitivity: ?CaseSensitivity = null,

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

    /// The Amazon Resource Name (ARN) of the SMB file share that you want to
    /// update.
    file_share_arn: []const u8,

    /// The name of the file share. Optional.
    ///
    /// `FileShareName` must be set if an S3 prefix name is set in
    /// `LocationARN`, or if an access point or access point alias is used.
    ///
    /// A valid SMB file share name cannot contain the following characters:
    /// `[`,`]`,`#`,`;`,``,`:`,`"`,`\`,`/`,`|`,`?`,`*`,`+`,
    /// or ASCII control characters `1-31`.
    file_share_name: ?[]const u8 = null,

    /// A value that enables guessing of the MIME type for uploaded objects based on
    /// file
    /// extensions. Set this value to `true` to enable MIME type guessing, otherwise
    /// set
    /// to `false`. The default value is `true`.
    ///
    /// Valid Values: `true` | `false`
    guess_mime_type_enabled: ?bool = null,

    /// A list of users or groups in the Active Directory that are not allowed to
    /// access the
    /// file share. A group must be prefixed with the @ character. Acceptable
    /// formats include:
    /// `DOMAIN\User1`, `user1`, `@group1`, and
    /// `@DOMAIN\group1`. Can only be set if Authentication is set to
    /// `ActiveDirectory`.
    invalid_user_list: ?[]const []const u8 = null,

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

    /// Specifies whether opportunistic locking is enabled for the SMB file share.
    ///
    /// Enabling opportunistic locking on case-sensitive shares is not recommended
    /// for
    /// workloads that involve access to files with the same name in different case.
    ///
    /// Valid Values: `true` | `false`
    oplocks_enabled: ?bool = null,

    /// A value that sets the write status of a file share. Set this value to `true`
    /// to set write status to read-only, otherwise set to `false`.
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

    /// Set this value to `true` to enable access control list (ACL) on the SMB file
    /// share. Set it to `false` to map file and directory permissions to the POSIX
    /// permissions.
    ///
    /// For more information, see [Using Windows ACLs to limit SMB file share
    /// access](https://docs.aws.amazon.com/filegateway/latest/files3/smb-acl.html)
    /// in the *Amazon S3 File Gateway User
    /// Guide*.
    ///
    /// Valid Values: `true` | `false`
    smbacl_enabled: ?bool = null,

    /// A list of users or groups in the Active Directory that are allowed to access
    /// the file
    /// share. A group must be prefixed with the @ character. Acceptable formats
    /// include:
    /// `DOMAIN\User1`, `user1`, `@group1`, and
    /// `@DOMAIN\group1`. Can only be set if Authentication is set to
    /// `ActiveDirectory`.
    valid_user_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .access_based_enumeration = "AccessBasedEnumeration",
        .admin_user_list = "AdminUserList",
        .audit_destination_arn = "AuditDestinationARN",
        .cache_attributes = "CacheAttributes",
        .case_sensitivity = "CaseSensitivity",
        .default_storage_class = "DefaultStorageClass",
        .encryption_type = "EncryptionType",
        .file_share_arn = "FileShareARN",
        .file_share_name = "FileShareName",
        .guess_mime_type_enabled = "GuessMIMETypeEnabled",
        .invalid_user_list = "InvalidUserList",
        .kms_encrypted = "KMSEncrypted",
        .kms_key = "KMSKey",
        .notification_policy = "NotificationPolicy",
        .object_acl = "ObjectACL",
        .oplocks_enabled = "OplocksEnabled",
        .read_only = "ReadOnly",
        .requester_pays = "RequesterPays",
        .smbacl_enabled = "SMBACLEnabled",
        .valid_user_list = "ValidUserList",
    };
};

pub const UpdateSMBFileShareOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated SMB file share.
    file_share_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_share_arn = "FileShareARN",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSMBFileShareInput, options: Options) !UpdateSMBFileShareOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSMBFileShareInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.UpdateSMBFileShare");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSMBFileShareOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSMBFileShareOutput, body, allocator);
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
