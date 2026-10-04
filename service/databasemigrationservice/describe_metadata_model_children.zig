const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OriginTypeValue = @import("origin_type_value.zig").OriginTypeValue;
const MetadataModelReference = @import("metadata_model_reference.zig").MetadataModelReference;

pub const DescribeMetadataModelChildrenInput = struct {
    /// Specifies the unique pagination token that indicates where the next page
    /// should start. If this parameter is specified, the response includes only
    /// records beyond the marker, up to the value specified by MaxRecords.
    marker: ?[]const u8 = null,

    /// The maximum number of metadata model children to include in the response. If
    /// more items exist than the specified MaxRecords value, a marker is included
    /// in the response so that the remaining results can be retrieved.
    max_records: ?i32 = null,

    /// The migration project name or Amazon Resource Name (ARN).
    migration_project_identifier: []const u8,

    /// Specifies whether to retrieve metadata from the source or target tree. Valid
    /// values: SOURCE | TARGET
    origin: OriginTypeValue,

    /// The JSON string that specifies which metadata model's children to retrieve.
    /// Only one selection rule with "rule-action": "explicit" can be provided. For
    /// more information, see [Selection
    /// Rules](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TableMapping.SelectionTransformation.Selections.html) in the DMS User Guide.
    selection_rules: []const u8,

    pub const json_field_names = .{
        .marker = "Marker",
        .max_records = "MaxRecords",
        .migration_project_identifier = "MigrationProjectIdentifier",
        .origin = "Origin",
        .selection_rules = "SelectionRules",
    };
};

pub const DescribeMetadataModelChildrenOutput = struct {
    /// Specifies the unique pagination token that makes it possible to display the
    /// next page of metadata model children. If a marker is returned, there are
    /// more metadata model children available.
    marker: ?[]const u8 = null,

    /// A list of child metadata models.
    metadata_model_children: ?[]const MetadataModelReference = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .metadata_model_children = "MetadataModelChildren",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMetadataModelChildrenInput, options: CallOptions) !DescribeMetadataModelChildrenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMetadataModelChildrenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeMetadataModelChildren");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMetadataModelChildrenOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMetadataModelChildrenOutput, body, allocator);
}
