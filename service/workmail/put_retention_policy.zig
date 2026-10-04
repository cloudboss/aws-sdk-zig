const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FolderConfiguration = @import("folder_configuration.zig").FolderConfiguration;

pub const PutRetentionPolicyInput = struct {
    /// The retention policy description.
    description: ?[]const u8 = null,

    /// The retention policy folder configurations.
    folder_configurations: []const FolderConfiguration,

    /// The retention policy ID.
    id: ?[]const u8 = null,

    /// The retention policy name.
    name: []const u8,

    /// The organization ID.
    organization_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .folder_configurations = "FolderConfigurations",
        .id = "Id",
        .name = "Name",
        .organization_id = "OrganizationId",
    };
};

pub const PutRetentionPolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRetentionPolicyInput, options: CallOptions) !PutRetentionPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRetentionPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.PutRetentionPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRetentionPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
