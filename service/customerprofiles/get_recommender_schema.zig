const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommenderSchemaField = @import("recommender_schema_field.zig").RecommenderSchemaField;
const RecommenderSchemaStatus = @import("recommender_schema_status.zig").RecommenderSchemaStatus;

pub const GetRecommenderSchemaInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The name of the recommender schema to retrieve.
    recommender_schema_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .recommender_schema_name = "RecommenderSchemaName",
    };
};

pub const GetRecommenderSchemaOutput = struct {
    /// The timestamp of when the recommender schema was created.
    created_at: i64,

    /// A map of dataset type to column definitions included in the schema.
    fields: ?[]const aws.map.MapEntry([]const RecommenderSchemaField) = null,

    /// The name of the recommender schema.
    recommender_schema_name: []const u8,

    /// The status of the recommender schema.
    status: RecommenderSchemaStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .fields = "Fields",
        .recommender_schema_name = "RecommenderSchemaName",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommenderSchemaInput, options: CallOptions) !GetRecommenderSchemaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommenderSchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/recommender-schemas/");
    try path_buf.appendSlice(allocator, input.recommender_schema_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommenderSchemaOutput {
    const result: GetRecommenderSchemaOutput = try aws.json.parseJsonObject(
        GetRecommenderSchemaOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
