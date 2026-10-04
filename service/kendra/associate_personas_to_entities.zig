const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityPersonaConfiguration = @import("entity_persona_configuration.zig").EntityPersonaConfiguration;
const FailedEntity = @import("failed_entity.zig").FailedEntity;

pub const AssociatePersonasToEntitiesInput = struct {
    /// The identifier of your Amazon Kendra experience.
    id: []const u8,

    /// The identifier of the index for your Amazon Kendra experience.
    index_id: []const u8,

    /// The personas that define the specific permissions of users or groups in
    /// your IAM Identity Center identity source. The available personas or access
    /// roles are `Owner` and `Viewer`. For more information
    /// on these personas, see [Providing
    /// access to your search
    /// page](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html#access-search-experience).
    personas: []const EntityPersonaConfiguration,

    pub const json_field_names = .{
        .id = "Id",
        .index_id = "IndexId",
        .personas = "Personas",
    };
};

pub const AssociatePersonasToEntitiesOutput = struct {
    /// Lists the users or groups in your IAM Identity Center identity source that
    /// failed to properly configure with your Amazon Kendra experience.
    failed_entity_list: ?[]const FailedEntity = null,

    pub const json_field_names = .{
        .failed_entity_list = "FailedEntityList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociatePersonasToEntitiesInput, options: CallOptions) !AssociatePersonasToEntitiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociatePersonasToEntitiesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.AssociatePersonasToEntities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociatePersonasToEntitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociatePersonasToEntitiesOutput, body, allocator);
}
