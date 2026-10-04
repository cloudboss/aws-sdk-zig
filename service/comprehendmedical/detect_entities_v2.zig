const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Entity = @import("entity.zig").Entity;
const UnmappedAttribute = @import("unmapped_attribute.zig").UnmappedAttribute;

pub const DetectEntitiesV2Input = struct {
    /// A UTF-8 string containing the clinical content being examined for entities.
    text: []const u8,

    pub const json_field_names = .{
        .text = "Text",
    };
};

pub const DetectEntitiesV2Output = struct {
    /// The collection of medical entities extracted from the input text and their
    /// associated
    /// information. For each entity, the response provides the entity text, the
    /// entity category,
    /// where the entity text begins and ends, and the level of confidence in the
    /// detection and
    /// analysis. Attributes and traits of the entity are also returned.
    entities: ?[]const Entity = null,

    /// The version of the model used to analyze the documents. The version number
    /// looks like
    /// X.X.X. You can use this information to track the model used for a particular
    /// batch of
    /// documents.
    model_version: []const u8,

    /// If the result to the `DetectEntitiesV2` operation was truncated, include the
    /// `PaginationToken` to fetch the next page of entities.
    pagination_token: ?[]const u8 = null,

    /// Attributes extracted from the input text that couldn't be related to an
    /// entity.
    unmapped_attributes: ?[]const UnmappedAttribute = null,

    pub const json_field_names = .{
        .entities = "Entities",
        .model_version = "ModelVersion",
        .pagination_token = "PaginationToken",
        .unmapped_attributes = "UnmappedAttributes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectEntitiesV2Input, options: CallOptions) !DetectEntitiesV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehendmedical", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectEntitiesV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehendmedical", "ComprehendMedical", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ComprehendMedical_20181030.DetectEntitiesV2");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectEntitiesV2Output {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DetectEntitiesV2Output, body, allocator);
}
