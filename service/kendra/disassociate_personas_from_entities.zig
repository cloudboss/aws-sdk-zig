const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FailedEntity = @import("failed_entity.zig").FailedEntity;

pub const DisassociatePersonasFromEntitiesInput = struct {
    /// The identifiers of users or groups in your IAM Identity Center identity
    /// source. For example, user IDs could be user emails.
    entity_ids: []const []const u8,

    /// The identifier of your Amazon Kendra experience.
    id: []const u8,

    /// The identifier of the index for your Amazon Kendra experience.
    index_id: []const u8,

    pub const json_field_names = .{
        .entity_ids = "EntityIds",
        .id = "Id",
        .index_id = "IndexId",
    };
};

pub const DisassociatePersonasFromEntitiesOutput = struct {
    /// Lists the users or groups in your IAM Identity Center identity source that
    /// failed to properly remove access to your Amazon Kendra experience.
    failed_entity_list: ?[]const FailedEntity = null,

    pub const json_field_names = .{
        .failed_entity_list = "FailedEntityList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociatePersonasFromEntitiesInput, options: CallOptions) !DisassociatePersonasFromEntitiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociatePersonasFromEntitiesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DisassociatePersonasFromEntities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociatePersonasFromEntitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociatePersonasFromEntitiesOutput, body, allocator);
}
