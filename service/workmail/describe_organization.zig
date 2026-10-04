const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeOrganizationInput = struct {
    /// The identifier for the organization to be described.
    organization_id: []const u8,

    pub const json_field_names = .{
        .organization_id = "OrganizationId",
    };
};

pub const DescribeOrganizationOutput = struct {
    /// The alias for an organization.
    alias: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the organization.
    arn: ?[]const u8 = null,

    /// The date at which the organization became usable in the WorkMail context, in
    /// UNIX epoch
    /// time format.
    completed_date: ?i64 = null,

    /// The default mail domain associated with the organization.
    default_mail_domain: ?[]const u8 = null,

    /// The identifier for the directory associated with an WorkMail organization.
    directory_id: ?[]const u8 = null,

    /// The type of directory associated with the WorkMail organization.
    directory_type: ?[]const u8 = null,

    /// (Optional) The error message indicating if unexpected behavior was
    /// encountered with
    /// regards to the organization.
    error_message: ?[]const u8 = null,

    /// Indicates if interoperability is enabled for this organization.
    interoperability_enabled: ?bool = null,

    /// The user ID of the migration admin if migration is enabled for the
    /// organization.
    migration_admin: ?[]const u8 = null,

    /// The identifier of an organization.
    organization_id: ?[]const u8 = null,

    /// The state of an organization.
    state: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .arn = "ARN",
        .completed_date = "CompletedDate",
        .default_mail_domain = "DefaultMailDomain",
        .directory_id = "DirectoryId",
        .directory_type = "DirectoryType",
        .error_message = "ErrorMessage",
        .interoperability_enabled = "InteroperabilityEnabled",
        .migration_admin = "MigrationAdmin",
        .organization_id = "OrganizationId",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOrganizationInput, options: CallOptions) !DescribeOrganizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOrganizationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.DescribeOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeOrganizationOutput, body, allocator);
}
