const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HomeDirectoryMapEntry = @import("home_directory_map_entry.zig").HomeDirectoryMapEntry;
const HomeDirectoryType = @import("home_directory_type.zig").HomeDirectoryType;
const PosixProfile = @import("posix_profile.zig").PosixProfile;
const Tag = @import("tag.zig").Tag;

pub const CreateUserInput = struct {
    /// The landing directory (folder) for a user when they log in to the server
    /// using the client.
    ///
    /// A `HomeDirectory` example is `/bucket_name/home/mydirectory`.
    ///
    /// You can use the `HomeDirectory` parameter for `HomeDirectoryType` when it is
    /// set to either `PATH` or `LOGICAL`.
    home_directory: ?[]const u8 = null,

    /// Logical directory mappings that specify what Amazon S3 or Amazon EFS paths
    /// and keys should be visible to your user and how you want to make them
    /// visible. You must specify the `Entry` and `Target` pair, where `Entry` shows
    /// how the path is made visible and `Target` is the actual Amazon S3 or Amazon
    /// EFS path. If you only specify a target, it is displayed as is. You also must
    /// ensure that your Identity and Access Management (IAM) role provides access
    /// to paths in `Target`. This value can be set only when `HomeDirectoryType` is
    /// set to *LOGICAL*.
    ///
    /// The following is an `Entry` and `Target` pair example.
    ///
    /// `[ { "Entry": "/directory1", "Target": "/bucket_name/home/mydirectory" } ]`
    ///
    /// In most cases, you can use this value instead of the session policy to lock
    /// your user down to the designated home directory ("`chroot`"). To do this,
    /// you can set `Entry` to `/` and set `Target` to the value the user should see
    /// for their home directory when they log in.
    ///
    /// The following is an `Entry` and `Target` pair example for `chroot`.
    ///
    /// `[ { "Entry": "/", "Target": "/bucket_name/home/mydirectory" } ]`
    home_directory_mappings: ?[]const HomeDirectoryMapEntry = null,

    /// The type of landing directory (folder) that you want your users' home
    /// directory to be when they log in to the server. If you set it to `PATH`, the
    /// user will see the absolute Amazon S3 bucket or Amazon EFS path as is in
    /// their file transfer protocol clients. If you set it to `LOGICAL`, you need
    /// to provide mappings in the `HomeDirectoryMappings` for how you want to make
    /// Amazon S3 or Amazon EFS paths visible to your users.
    ///
    /// If `HomeDirectoryType` is `LOGICAL`, you must provide mappings, using the
    /// `HomeDirectoryMappings` parameter. If, on the other hand,
    /// `HomeDirectoryType` is `PATH`, you provide an absolute path using the
    /// `HomeDirectory` parameter. You cannot have both `HomeDirectory` and
    /// `HomeDirectoryMappings` in your template.
    home_directory_type: ?HomeDirectoryType = null,

    /// A session policy for your user so that you can use the same Identity and
    /// Access Management (IAM) role across multiple users. This policy scopes down
    /// a user's access to portions of their Amazon S3 bucket. Variables that you
    /// can use inside this policy include `${Transfer:UserName}`,
    /// `${Transfer:HomeDirectory}`, and `${Transfer:HomeBucket}`.
    ///
    /// This policy applies only when the domain of `ServerId` is Amazon S3. Amazon
    /// EFS does not use session policies.
    ///
    /// For session policies, Transfer Family stores the policy as a JSON blob,
    /// instead of the Amazon Resource Name (ARN) of the policy. You save the policy
    /// as a JSON blob and pass it in the `Policy` argument.
    ///
    /// For an example of a session policy, see [Example session
    /// policy](https://docs.aws.amazon.com/transfer/latest/userguide/session-policy.html).
    ///
    /// For more information, see
    /// [AssumeRole](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html) in the *Amazon Web Services Security Token Service API Reference*.
    policy: ?[]const u8 = null,

    /// Specifies the full POSIX identity, including user ID (`Uid`), group ID
    /// (`Gid`), and any secondary groups IDs (`SecondaryGids`), that controls your
    /// users' access to your Amazon EFS file systems. The POSIX permissions that
    /// are set on files and directories in Amazon EFS determine the level of access
    /// your users get when transferring files into and out of your Amazon EFS file
    /// systems.
    posix_profile: ?PosixProfile = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that controls your users' access to your Amazon S3 bucket or Amazon EFS
    /// file system. The policies attached to this role determine the level of
    /// access that you want to provide your users when transferring files into and
    /// out of your Amazon S3 bucket or Amazon EFS file system. The IAM role should
    /// also contain a trust relationship that allows the server to access your
    /// resources when servicing your users' transfer requests.
    role: []const u8,

    /// A system-assigned unique identifier for a server instance. This is the
    /// specific server that you added your user to.
    server_id: []const u8,

    /// The public portion of the Secure Shell (SSH) key used to authenticate the
    /// user to the server.
    ///
    /// The three standard SSH public key format elements are `<key type>`, `<body
    /// base64>`, and an optional `<comment>`, with spaces between each element.
    ///
    /// Transfer Family accepts RSA, ECDSA, and ED25519 keys.
    ///
    /// * For RSA keys, the key type is `ssh-rsa`.
    /// * For ED25519 keys, the key type is `ssh-ed25519`.
    /// * For ECDSA keys, the key type is either `ecdsa-sha2-nistp256`,
    ///   `ecdsa-sha2-nistp384`, or `ecdsa-sha2-nistp521`, depending on the size of
    ///   the key you generated.
    ssh_public_key_body: ?[]const u8 = null,

    /// Key-value pairs that can be used to group and search for users. Tags are
    /// metadata attached to users for any purpose.
    tags: ?[]const Tag = null,

    /// A unique string that identifies a user and is associated with a `ServerId`.
    /// This user name must be a minimum of 3 and a maximum of 100 characters long.
    /// The following are valid characters: a-z, A-Z, 0-9, underscore '_', hyphen
    /// '-', period '.', and at sign '@'. The user name can't start with a hyphen,
    /// period, or at sign.
    user_name: []const u8,

    pub const json_field_names = .{
        .home_directory = "HomeDirectory",
        .home_directory_mappings = "HomeDirectoryMappings",
        .home_directory_type = "HomeDirectoryType",
        .policy = "Policy",
        .posix_profile = "PosixProfile",
        .role = "Role",
        .server_id = "ServerId",
        .ssh_public_key_body = "SshPublicKeyBody",
        .tags = "Tags",
        .user_name = "UserName",
    };
};

pub const CreateUserOutput = struct {
    /// The identifier of the server that the user is attached to.
    server_id: []const u8,

    /// A unique string that identifies a Transfer Family user.
    user_name: []const u8,

    pub const json_field_names = .{
        .server_id = "ServerId",
        .user_name = "UserName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserInput, options: CallOptions) !CreateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transfer");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.CreateUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUserOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateUserOutput, body, allocator);
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
