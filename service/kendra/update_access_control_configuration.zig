const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Principal = @import("principal.zig").Principal;
const HierarchicalPrincipal = @import("hierarchical_principal.zig").HierarchicalPrincipal;

pub const UpdateAccessControlConfigurationInput = struct {
    /// Information you want to update on principals (users and/or groups) and which
    /// documents
    /// they should have access to. This is useful for user context filtering, where
    /// search
    /// results are filtered based on the user or their group access to documents.
    access_control_list: ?[]const Principal = null,

    /// A new description for the access control configuration.
    description: ?[]const u8 = null,

    /// The updated list of
    /// [principal](https://docs.aws.amazon.com/kendra/latest/dg/API_Principal.html)
    /// lists that define the
    /// hierarchy for which documents users should have access to.
    hierarchical_access_control_list: ?[]const HierarchicalPrincipal = null,

    /// The identifier of the access control configuration you want to update.
    id: []const u8,

    /// The identifier of the index for an access control configuration.
    index_id: []const u8,

    /// A new name for the access control configuration.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_control_list = "AccessControlList",
        .description = "Description",
        .hierarchical_access_control_list = "HierarchicalAccessControlList",
        .id = "Id",
        .index_id = "IndexId",
        .name = "Name",
    };
};

pub const UpdateAccessControlConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccessControlConfigurationInput, options: CallOptions) !UpdateAccessControlConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccessControlConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.UpdateAccessControlConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccessControlConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
