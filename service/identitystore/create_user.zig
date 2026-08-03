const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const Address = @import("address.zig").Address;
const Email = @import("email.zig").Email;
const Name = @import("name.zig").Name;
const PhoneNumber = @import("phone_number.zig").PhoneNumber;
const Photo = @import("photo.zig").Photo;
const Role = @import("role.zig").Role;

pub const CreateUserInput = struct {
    /// A list of `Address` objects containing addresses associated with the user.
    addresses: ?[]const Address = null,

    /// The user's birthdate in YYYY-MM-DD format. This field supports standard date
    /// format for storing personal information.
    birthdate: ?[]const u8 = null,

    /// A string containing the name of the user. This value is typically formatted
    /// for display when the user is referenced. For example, "John Doe." When used
    /// in IAM Identity Center, this parameter is required.
    display_name: ?[]const u8 = null,

    /// A list of `Email` objects containing email addresses associated with the
    /// user.
    emails: ?[]const Email = null,

    /// A map with additional attribute extensions for the user. Each map key
    /// corresponds to an extension name, while map values represent extension data
    /// in `Document` type (not supported by Java V1, Go V1 and older versions of
    /// the CLI). `aws:identitystore:enterprise` is the only supported extension
    /// name.
    extensions: ?[]const aws.map.StringMapEntry = null,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// A string containing the geographical region or location of the user.
    locale: ?[]const u8 = null,

    /// An object containing the name of the user. When used in IAM Identity Center,
    /// this parameter is required.
    name: ?Name = null,

    /// A string containing an alternate name for the user.
    nick_name: ?[]const u8 = null,

    /// A list of `PhoneNumber` objects containing phone numbers associated with the
    /// user.
    phone_numbers: ?[]const PhoneNumber = null,

    /// A list of photos associated with the user. You can add up to 3 photos per
    /// user. Each photo can include a value, type, display name, and primary
    /// designation.
    photos: ?[]const Photo = null,

    /// A string containing the preferred language of the user. For example,
    /// "American English" or "en-us."
    preferred_language: ?[]const u8 = null,

    /// A string containing a URL that might be associated with the user.
    profile_url: ?[]const u8 = null,

    /// A list of `Role` objects containing roles associated with the user.
    roles: ?[]const Role = null,

    /// A string containing the time zone of the user.
    timezone: ?[]const u8 = null,

    /// A string containing the title of the user. Possible values are left
    /// unspecified. The value can vary based on your specific use case.
    title: ?[]const u8 = null,

    /// A unique string used to identify the user. The length limit is 128
    /// characters. This value can consist of letters, accented characters, symbols,
    /// numbers, and punctuation. This value is specified at the time the user is
    /// created and stored as an attribute of the user object in the identity store.
    /// `Administrator` and `AWSAdministrators` are reserved names and can't be used
    /// for users or groups.
    user_name: ?[]const u8 = null,

    /// A string indicating the type of user. Possible values are left unspecified.
    /// The value can vary based on your specific use case.
    user_type: ?[]const u8 = null,

    /// The user's personal website or blog URL. This field allows users to provide
    /// a link to their personal or professional website.
    website: ?[]const u8 = null,

    pub const json_field_names = .{
        .addresses = "Addresses",
        .birthdate = "Birthdate",
        .display_name = "DisplayName",
        .emails = "Emails",
        .extensions = "Extensions",
        .identity_store_id = "IdentityStoreId",
        .locale = "Locale",
        .name = "Name",
        .nick_name = "NickName",
        .phone_numbers = "PhoneNumbers",
        .photos = "Photos",
        .preferred_language = "PreferredLanguage",
        .profile_url = "ProfileUrl",
        .roles = "Roles",
        .timezone = "Timezone",
        .title = "Title",
        .user_name = "UserName",
        .user_type = "UserType",
        .website = "Website",
    };
};

pub const CreateUserOutput = struct {
    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// The identifier of the newly created user in the identity store.
    user_id: []const u8,

    pub const json_field_names = .{
        .identity_store_id = "IdentityStoreId",
        .user_id = "UserId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserInput, options: CallOptions) !CreateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "identitystore", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("identitystore", "identitystore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.CreateUser");

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
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
