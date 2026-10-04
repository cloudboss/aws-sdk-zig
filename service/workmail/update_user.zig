const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserRole = @import("user_role.zig").UserRole;

pub const UpdateUserInput = struct {
    /// Updates the user's city.
    city: ?[]const u8 = null,

    /// Updates the user's company.
    company: ?[]const u8 = null,

    /// Updates the user's country.
    country: ?[]const u8 = null,

    /// Updates the user's department.
    department: ?[]const u8 = null,

    /// Updates the display name of the user.
    display_name: ?[]const u8 = null,

    /// Updates the user's first name.
    first_name: ?[]const u8 = null,

    /// If enabled, the user is hidden from the global address list.
    hidden_from_global_address_list: ?bool = null,

    /// User ID from the IAM Identity Center. If this parameter is empty it will be
    /// updated automatically when the user logs in for the first time to the
    /// mailbox associated with WorkMail.
    identity_provider_user_id: ?[]const u8 = null,

    /// Updates the user's initials.
    initials: ?[]const u8 = null,

    /// Updates the user's job title.
    job_title: ?[]const u8 = null,

    /// Updates the user's last name.
    last_name: ?[]const u8 = null,

    /// Updates the user's office.
    office: ?[]const u8 = null,

    /// The identifier for the organization under which the user exists.
    organization_id: []const u8,

    /// Updates the user role.
    ///
    /// You cannot pass *SYSTEM_USER* or *RESOURCE*.
    role: ?UserRole = null,

    /// Updates the user's street address.
    street: ?[]const u8 = null,

    /// Updates the user's contact details.
    telephone: ?[]const u8 = null,

    /// The identifier for the user to be updated.
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

    /// Updates the user's zip code.
    zip_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .city = "City",
        .company = "Company",
        .country = "Country",
        .department = "Department",
        .display_name = "DisplayName",
        .first_name = "FirstName",
        .hidden_from_global_address_list = "HiddenFromGlobalAddressList",
        .identity_provider_user_id = "IdentityProviderUserId",
        .initials = "Initials",
        .job_title = "JobTitle",
        .last_name = "LastName",
        .office = "Office",
        .organization_id = "OrganizationId",
        .role = "Role",
        .street = "Street",
        .telephone = "Telephone",
        .user_id = "UserId",
        .zip_code = "ZipCode",
    };
};

pub const UpdateUserOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserInput, options: CallOptions) !UpdateUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.UpdateUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
