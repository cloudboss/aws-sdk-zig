const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteOrganizationInput = struct {
    /// The idempotency token associated with the request.
    client_token: ?[]const u8 = null,

    /// If true, deletes the AWS Directory Service directory associated with the
    /// organization.
    delete_directory: ?bool = null,

    /// Deletes IAM Identity Center application for WorkMail. This action does not
    /// affect authentication settings for any organization.
    delete_identity_center_application: ?bool = null,

    /// Deletes a WorkMail organization even if the organization has enabled users.
    force_delete: ?bool = null,

    /// The organization ID.
    organization_id: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .delete_directory = "DeleteDirectory",
        .delete_identity_center_application = "DeleteIdentityCenterApplication",
        .force_delete = "ForceDelete",
        .organization_id = "OrganizationId",
    };
};

pub const DeleteOrganizationOutput = struct {
    /// The organization ID.
    organization_id: ?[]const u8 = null,

    /// The state of the organization.
    state: ?[]const u8 = null,

    pub const json_field_names = .{
        .organization_id = "OrganizationId",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteOrganizationInput, options: CallOptions) !DeleteOrganizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteOrganizationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.DeleteOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteOrganizationOutput, body, allocator);
}
