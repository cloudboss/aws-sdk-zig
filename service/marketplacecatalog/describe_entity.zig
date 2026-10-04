const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeEntityInput = struct {
    /// Required. The catalog related to the request. Fixed value:
    /// `AWSMarketplace`
    catalog: []const u8,

    /// Required. The unique ID of the entity to describe.
    entity_id: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .entity_id = "EntityId",
    };
};

pub const DescribeEntityOutput = struct {
    /// This stringified JSON object includes the details of the entity.
    details: ?[]const u8 = null,

    /// The JSON value of the details specific to the entity.
    ///
    /// To download "DetailsDocument" shapes, see the
    /// [Python](https://github.com/awslabs/aws-marketplace-catalog-api-shapes-for-python)
    /// and
    /// [Java](https://github.com/awslabs/aws-marketplace-catalog-api-shapes-for-java/tree/main) shapes on GitHub.
    details_document: ?[]const u8 = null,

    /// The ARN associated to the unique identifier for the entity referenced in
    /// this
    /// request.
    entity_arn: ?[]const u8 = null,

    /// The identifier of the entity, in the format of
    /// `EntityId@RevisionId`.
    entity_identifier: ?[]const u8 = null,

    /// The named type of the entity, in the format of `EntityType@Version`.
    entity_type: ?[]const u8 = null,

    /// The last modified date of the entity, in ISO 8601 format
    /// (2018-02-27T13:45:22Z).
    last_modified_date: ?[]const u8 = null,

    pub const json_field_names = .{
        .details = "Details",
        .details_document = "DetailsDocument",
        .entity_arn = "EntityArn",
        .entity_identifier = "EntityIdentifier",
        .entity_type = "EntityType",
        .last_modified_date = "LastModifiedDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEntityInput, options: CallOptions) !DescribeEntityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEntityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("catalog.marketplace", "Marketplace Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DescribeEntity";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "catalog=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.catalog);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "entityId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.entity_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEntityOutput {
    var result: DescribeEntityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeEntityOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
