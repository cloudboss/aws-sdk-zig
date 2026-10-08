const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexCapacityConfiguration = @import("index_capacity_configuration.zig").IndexCapacityConfiguration;
const DocumentAttributeConfiguration = @import("document_attribute_configuration.zig").DocumentAttributeConfiguration;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const IndexStatistics = @import("index_statistics.zig").IndexStatistics;
const IndexStatus = @import("index_status.zig").IndexStatus;
const IndexType = @import("index_type.zig").IndexType;

pub const GetIndexInput = struct {
    /// The identifier of the Amazon Q Business application connected to the index.
    application_id: []const u8,

    /// The identifier of the Amazon Q Business index you want information on.
    index_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .index_id = "indexId",
    };
};

pub const GetIndexOutput = struct {
    /// The identifier of the Amazon Q Business application associated with the
    /// index.
    application_id: ?[]const u8 = null,

    /// The storage capacity units chosen for your Amazon Q Business index.
    capacity_configuration: ?IndexCapacityConfiguration = null,

    /// The Unix timestamp when the Amazon Q Business index was created.
    created_at: ?i64 = null,

    /// The description for the Amazon Q Business index.
    description: ?[]const u8 = null,

    /// The name of the Amazon Q Business index.
    display_name: ?[]const u8 = null,

    /// Configuration information for document attributes or metadata. Document
    /// metadata are fields associated with your documents. For example, the company
    /// department name associated with each document. For more information, see
    /// [Understanding document
    /// attributes](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/doc-attributes-types.html#doc-attributes).
    document_attribute_configurations: ?[]const DocumentAttributeConfiguration = null,

    /// When the `Status` field value is `FAILED`, the `ErrorMessage` field contains
    /// a message that explains why.
    @"error": ?ErrorDetail = null,

    /// The Amazon Resource Name (ARN) of the Amazon Q Business index.
    index_arn: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business index.
    index_id: ?[]const u8 = null,

    /// Provides information about the number of documents indexed.
    index_statistics: ?IndexStatistics = null,

    /// The current status of the index. When the value is `ACTIVE`, the index is
    /// ready for use. If the `Status` field value is `FAILED`, the `ErrorMessage`
    /// field contains a message that explains why.
    status: ?IndexStatus = null,

    /// The type of index attached to your Amazon Q Business application.
    type: ?IndexType = null,

    /// The Unix timestamp when the Amazon Q Business index was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .capacity_configuration = "capacityConfiguration",
        .created_at = "createdAt",
        .description = "description",
        .display_name = "displayName",
        .document_attribute_configurations = "documentAttributeConfigurations",
        .@"error" = "error",
        .index_arn = "indexArn",
        .index_id = "indexId",
        .index_statistics = "indexStatistics",
        .status = "status",
        .type = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIndexInput, options: CallOptions) !GetIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIndexOutput {
    const result: GetIndexOutput = try aws.json.parseJsonObject(
        GetIndexOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
