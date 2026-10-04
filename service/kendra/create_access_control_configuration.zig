const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Principal = @import("principal.zig").Principal;
const HierarchicalPrincipal = @import("hierarchical_principal.zig").HierarchicalPrincipal;

pub const CreateAccessControlConfigurationInput = struct {
    /// Information on principals (users and/or groups) and which documents they
    /// should have
    /// access to. This is useful for user context filtering, where search results
    /// are filtered
    /// based on the user or their group access to documents.
    access_control_list: ?[]const Principal = null,

    /// A token that you provide to identify the request to create an access control
    /// configuration. Multiple calls to the `CreateAccessControlConfiguration` API
    /// with the same client token will create only one access control
    /// configuration.
    client_token: ?[]const u8 = null,

    /// A description for the access control configuration.
    description: ?[]const u8 = null,

    /// The list of
    /// [principal](https://docs.aws.amazon.com/kendra/latest/dg/API_Principal.html)
    /// lists that define the hierarchy for which documents users should
    /// have access to.
    hierarchical_access_control_list: ?[]const HierarchicalPrincipal = null,

    /// The identifier of the index to create an access control configuration for
    /// your
    /// documents.
    index_id: []const u8,

    /// A name for the access control configuration.
    name: []const u8,

    pub const json_field_names = .{
        .access_control_list = "AccessControlList",
        .client_token = "ClientToken",
        .description = "Description",
        .hierarchical_access_control_list = "HierarchicalAccessControlList",
        .index_id = "IndexId",
        .name = "Name",
    };
};

pub const CreateAccessControlConfigurationOutput = struct {
    /// The identifier of the access control configuration for your documents in an
    /// index.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessControlConfigurationInput, options: CallOptions) !CreateAccessControlConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccessControlConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.CreateAccessControlConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccessControlConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAccessControlConfigurationOutput, body, allocator);
}
