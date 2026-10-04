const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Address = @import("address.zig").Address;
const Email = @import("email.zig").Email;
const ExternalId = @import("external_id.zig").ExternalId;
const Name = @import("name.zig").Name;
const PhoneNumber = @import("phone_number.zig").PhoneNumber;
const Photo = @import("photo.zig").Photo;
const Role = @import("role.zig").Role;
const UserStatus = @import("user_status.zig").UserStatus;

pub const DescribeUserInput = struct {
    /// A collection of extension names indicating what extensions the service
    /// should retrieve alongside other user attributes.
    /// `aws:identitystore:enterprise` is the only supported extension name.
    extensions: ?[]const []const u8 = null,

    /// The globally unique identifier for the identity store, such as
    /// `d-1234567890`. In this example, `d-` is a fixed prefix, and `1234567890` is
    /// a randomly generated string that contains numbers and lower case letters.
    /// This value is generated at the time that a new identity store is created.
    ///
    /// You can specify the identity store by ID or by Amazon Resource Name (ARN).
    /// For example, identity store ID `d-1234567890` or identity store ARN
    /// `arn:aws:identitystore::111122223333:identitystore/d-1234567890`.
    identity_store_id: []const u8,

    /// The identifier for a user in the identity store.
    ///
    /// You can specify the user by ID or by Amazon Resource Name (ARN). For
    /// example, user ID `a1b2c3d4-5678-90ab-cdef-EXAMPLE11111` or user ARN
    /// `arn:aws:identitystore:::user/a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    user_id: []const u8,

    pub const json_field_names = .{
        .extensions = "Extensions",
        .identity_store_id = "IdentityStoreId",
        .user_id = "UserId",
    };
};

pub const DescribeUserOutput = struct {
    /// The physical address of the user.
    addresses: ?[]const Address = null,

    /// The user's birthdate in YYYY-MM-DD format. This field returns the stored
    /// birthdate information for the user.
    birthdate: ?[]const u8 = null,

    /// The date and time the user was created.
    created_at: ?i64 = null,

    /// The identifier of the user or system that created the user.
    created_by: ?[]const u8 = null,

    /// The display name of the user.
    display_name: ?[]const u8 = null,

    /// The email address of the user.
    emails: ?[]const Email = null,

    /// A map of explicitly requested attribute extensions associated with the user.
    /// Not populated if the user has no requested extensions.
    extensions: ?[]const aws.map.StringMapEntry = null,

    /// A list of `ExternalId` objects that contains the identifiers issued to this
    /// resource by an external identity provider.
    external_ids: ?[]const ExternalId = null,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// A string containing the geographical region or location of the user.
    locale: ?[]const u8 = null,

    /// The name of the user.
    name: ?Name = null,

    /// An alternative descriptive name for the user.
    nick_name: ?[]const u8 = null,

    /// A list of `PhoneNumber` objects associated with a user.
    phone_numbers: ?[]const PhoneNumber = null,

    /// A list of photos associated with the user. Returns up to 3 photos with their
    /// associated metadata including type, display name, and primary designation.
    photos: ?[]const Photo = null,

    /// The preferred language of the user.
    preferred_language: ?[]const u8 = null,

    /// A URL link for the user's profile.
    profile_url: ?[]const u8 = null,

    /// The current revision of the user in the identity store. This value changes
    /// each time the user is modified.
    revision: []const u8,

    /// The roles of the user.
    roles: ?[]const Role = null,

    /// The time zone for a user.
    timezone: ?[]const u8 = null,

    /// A string containing the title of the user.
    title: ?[]const u8 = null,

    /// The date and time the user was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the user or system that last updated the user.
    updated_by: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the user in the identity store. For
    /// example,
    /// `arn:aws:identitystore:::user/a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    user_arn: []const u8,

    /// The identifier for a user in the identity store.
    user_id: []const u8,

    /// A unique string used to identify the user. The length limit is 128
    /// characters. This value can consist of letters, accented characters, symbols,
    /// numbers, and punctuation. This value is specified at the time the user is
    /// created and stored as an attribute of the user object in the identity store.
    user_name: ?[]const u8 = null,

    /// The current status of the user account.
    user_status: ?UserStatus = null,

    /// A string indicating the type of user.
    user_type: ?[]const u8 = null,

    /// The user's personal website or blog URL. Returns the stored website
    /// information for the user.
    website: ?[]const u8 = null,

    pub const json_field_names = .{
        .addresses = "Addresses",
        .birthdate = "Birthdate",
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .display_name = "DisplayName",
        .emails = "Emails",
        .extensions = "Extensions",
        .external_ids = "ExternalIds",
        .identity_store_id = "IdentityStoreId",
        .locale = "Locale",
        .name = "Name",
        .nick_name = "NickName",
        .phone_numbers = "PhoneNumbers",
        .photos = "Photos",
        .preferred_language = "PreferredLanguage",
        .profile_url = "ProfileUrl",
        .revision = "Revision",
        .roles = "Roles",
        .timezone = "Timezone",
        .title = "Title",
        .updated_at = "UpdatedAt",
        .updated_by = "UpdatedBy",
        .user_arn = "UserArn",
        .user_id = "UserId",
        .user_name = "UserName",
        .user_status = "UserStatus",
        .user_type = "UserType",
        .website = "Website",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUserInput, options: CallOptions) !DescribeUserOutput {
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUserInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSIdentityStore.DescribeUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUserOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeUserOutput, body, allocator);
}
