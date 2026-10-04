const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityState = @import("entity_state.zig").EntityState;
const UserRole = @import("user_role.zig").UserRole;

pub const DescribeUserInput = struct {
    /// The identifier for the organization under which the user exists.
    organization_id: []const u8,

    /// The identifier for the user to be described.
    ///
    /// The identifier can be the *UserId*, *Username*, or *email*. The following
    /// identity formats are available:
    ///
    /// * User ID: 12345678-1234-1234-1234-123456789012 or
    ///   S-1-1-12-1234567890-123456789-123456789-1234
    ///
    /// * Email address: user@domain.tld
    ///
    /// * User name: user
    user_id: []const u8,

    pub const json_field_names = .{
        .organization_id = "OrganizationId",
        .user_id = "UserId",
    };
};

pub const DescribeUserOutput = struct {
    /// City where the user is located.
    city: ?[]const u8 = null,

    /// Company of the user.
    company: ?[]const u8 = null,

    /// Country where the user is located.
    country: ?[]const u8 = null,

    /// Department of the user.
    department: ?[]const u8 = null,

    /// The date and time at which the user was disabled for WorkMail usage, in UNIX
    /// epoch
    /// time format.
    disabled_date: ?i64 = null,

    /// The display name of the user.
    display_name: ?[]const u8 = null,

    /// The email of the user.
    email: ?[]const u8 = null,

    /// The date and time at which the user was enabled for WorkMailusage, in UNIX
    /// epoch
    /// time format.
    enabled_date: ?i64 = null,

    /// First name of the user.
    first_name: ?[]const u8 = null,

    /// If enabled, the user is hidden from the global address list.
    hidden_from_global_address_list: ?bool = null,

    /// Identity Store ID from the IAM Identity Center. If this parameter is empty
    /// it will be updated automatically when the user logs in for the first time to
    /// the mailbox associated with WorkMail.
    identity_provider_identity_store_id: ?[]const u8 = null,

    /// User ID from the IAM Identity Center. If this parameter is empty it will be
    /// updated automatically when the user logs in for the first time to the
    /// mailbox associated with WorkMail.
    identity_provider_user_id: ?[]const u8 = null,

    /// Initials of the user.
    initials: ?[]const u8 = null,

    /// Job title of the user.
    job_title: ?[]const u8 = null,

    /// Last name of the user.
    last_name: ?[]const u8 = null,

    /// The date when the mailbox was removed for the user.
    mailbox_deprovisioned_date: ?i64 = null,

    /// The date when the mailbox was created for the user.
    mailbox_provisioned_date: ?i64 = null,

    /// The name for the user.
    name: ?[]const u8 = null,

    /// Office where the user is located.
    office: ?[]const u8 = null,

    /// The state of a user: enabled (registered to WorkMail) or disabled
    /// (deregistered or
    /// never registered to WorkMail).
    state: ?EntityState = null,

    /// Street where the user is located.
    street: ?[]const u8 = null,

    /// User's contact number.
    telephone: ?[]const u8 = null,

    /// The identifier for the described user.
    user_id: ?[]const u8 = null,

    /// In certain cases, other entities are modeled as users. If interoperability
    /// is
    /// enabled, resources are imported into WorkMail as users. Because different
    /// WorkMail
    /// organizations rely on different directory types, administrators can
    /// distinguish between an
    /// unregistered user (account is disabled and has a user role) and the
    /// directory
    /// administrators. The values are USER, RESOURCE, SYSTEM_USER, and REMOTE_USER.
    user_role: ?UserRole = null,

    /// Zip code of the user.
    zip_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .city = "City",
        .company = "Company",
        .country = "Country",
        .department = "Department",
        .disabled_date = "DisabledDate",
        .display_name = "DisplayName",
        .email = "Email",
        .enabled_date = "EnabledDate",
        .first_name = "FirstName",
        .hidden_from_global_address_list = "HiddenFromGlobalAddressList",
        .identity_provider_identity_store_id = "IdentityProviderIdentityStoreId",
        .identity_provider_user_id = "IdentityProviderUserId",
        .initials = "Initials",
        .job_title = "JobTitle",
        .last_name = "LastName",
        .mailbox_deprovisioned_date = "MailboxDeprovisionedDate",
        .mailbox_provisioned_date = "MailboxProvisionedDate",
        .name = "Name",
        .office = "Office",
        .state = "State",
        .street = "Street",
        .telephone = "Telephone",
        .user_id = "UserId",
        .user_role = "UserRole",
        .zip_code = "ZipCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUserInput, options: CallOptions) !DescribeUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.DescribeUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUserOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeUserOutput, body, allocator);
}
