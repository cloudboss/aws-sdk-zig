const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CustomDirectoriesType = @import("custom_directories_type.zig").CustomDirectoriesType;
const EnforceMessageSigningType = @import("enforce_message_signing_type.zig").EnforceMessageSigningType;
const PreserveFilenameType = @import("preserve_filename_type.zig").PreserveFilenameType;
const AgreementStatusType = @import("agreement_status_type.zig").AgreementStatusType;

pub const UpdateAgreementInput = struct {
    /// Connectors are used to send files using either the AS2 or SFTP protocol. For
    /// the access role, provide the Amazon Resource Name (ARN) of the Identity and
    /// Access Management role to use.
    ///
    /// **For AS2 connectors**
    ///
    /// With AS2, you can send files by calling `StartFileTransfer` and specifying
    /// the file paths in the request parameter, `SendFilePaths`. We use the file’s
    /// parent directory (for example, for `--send-file-paths /bucket/dir/file.txt`,
    /// parent directory is `/bucket/dir/`) to temporarily store a processed AS2
    /// message file, store the MDN when we receive them from the partner, and write
    /// a final JSON file containing relevant metadata of the transmission. So, the
    /// `AccessRole` needs to provide read and write access to the parent directory
    /// of the file location used in the `StartFileTransfer` request. Additionally,
    /// you need to provide read and write access to the parent directory of the
    /// files that you intend to send with `StartFileTransfer`.
    ///
    /// If you are using Basic authentication for your AS2 connector, the access
    /// role requires the `secretsmanager:GetSecretValue` permission for the secret.
    /// If the secret is encrypted using a customer-managed key instead of the
    /// Amazon Web Services managed key in Secrets Manager, then the role also needs
    /// the `kms:Decrypt` permission for that key.
    ///
    /// **For SFTP connectors**
    ///
    /// Make sure that the access role provides read and write access to the parent
    /// directory of the file location that's used in the `StartFileTransfer`
    /// request. Additionally, make sure that the role provides
    /// `secretsmanager:GetSecretValue` permission to Secrets Manager.
    access_role: ?[]const u8 = null,

    /// A unique identifier for the agreement. This identifier is returned when you
    /// create an agreement.
    agreement_id: []const u8,

    /// To change the landing directory (folder) for files that are transferred,
    /// provide the bucket folder that you want to use; for example,
    /// `/*amzn-s3-demo-bucket*/*home*/*mydirectory* `.
    base_directory: ?[]const u8 = null,

    /// A `CustomDirectoriesType` structure. This structure specifies custom
    /// directories for storing various AS2 message files. You can specify
    /// directories for the following types of files.
    ///
    /// * Failed files
    /// * MDN files
    /// * Payload files
    /// * Status files
    /// * Temporary files
    custom_directories: ?CustomDirectoriesType = null,

    /// To replace the existing description, provide a short description for the
    /// agreement.
    description: ?[]const u8 = null,

    /// Determines whether or not unsigned messages from your trading partners will
    /// be accepted.
    ///
    /// * `ENABLED`: Transfer Family rejects unsigned messages from your trading
    ///   partner.
    /// * `DISABLED` (default value): Transfer Family accepts unsigned messages from
    ///   your trading partner.
    enforce_message_signing: ?EnforceMessageSigningType = null,

    /// A unique identifier for the AS2 local profile.
    ///
    /// To change the local profile identifier, provide a new value here.
    local_profile_id: ?[]const u8 = null,

    /// A unique identifier for the partner profile. To change the partner profile
    /// identifier, provide a new value here.
    partner_profile_id: ?[]const u8 = null,

    /// Determines whether or not Transfer Family appends a unique string of
    /// characters to the end of the AS2 message payload filename when saving it.
    ///
    /// * `ENABLED`: the filename provided by your trading parter is preserved when
    ///   the file is saved.
    /// * `DISABLED` (default value): when Transfer Family saves the file, the
    ///   filename is adjusted, as described in [File names and
    ///   locations](https://docs.aws.amazon.com/transfer/latest/userguide/send-as2-messages.html#file-names-as2).
    preserve_filename: ?PreserveFilenameType = null,

    /// A system-assigned unique identifier for a server instance. This is the
    /// specific server that the agreement uses.
    server_id: []const u8,

    /// You can update the status for the agreement, either activating an inactive
    /// agreement or the reverse.
    status: ?AgreementStatusType = null,

    pub const json_field_names = .{
        .access_role = "AccessRole",
        .agreement_id = "AgreementId",
        .base_directory = "BaseDirectory",
        .custom_directories = "CustomDirectories",
        .description = "Description",
        .enforce_message_signing = "EnforceMessageSigning",
        .local_profile_id = "LocalProfileId",
        .partner_profile_id = "PartnerProfileId",
        .preserve_filename = "PreserveFilename",
        .server_id = "ServerId",
        .status = "Status",
    };
};

pub const UpdateAgreementOutput = struct {
    /// A unique identifier for the agreement. This identifier is returned when you
    /// create an agreement.
    agreement_id: []const u8,

    pub const json_field_names = .{
        .agreement_id = "AgreementId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAgreementInput, options: Options) !UpdateAgreementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transfer");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateAgreementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "TransferService.UpdateAgreement");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateAgreementOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateAgreementOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
