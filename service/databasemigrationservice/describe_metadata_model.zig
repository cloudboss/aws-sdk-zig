const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OriginTypeValue = @import("origin_type_value.zig").OriginTypeValue;
const MetadataModelReference = @import("metadata_model_reference.zig").MetadataModelReference;

pub const DescribeMetadataModelInput = struct {
    /// The migration project name or Amazon Resource Name (ARN).
    migration_project_identifier: []const u8,

    /// Specifies whether to retrieve metadata from the source or target tree. Valid
    /// values: SOURCE | TARGET
    origin: OriginTypeValue,

    /// The JSON string that specifies which metadata model to retrieve. Only one
    /// selection rule with "rule-action": "explicit" can be provided. For more
    /// information, see [Selection
    /// Rules](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TableMapping.SelectionTransformation.Selections.html) in the DMS User Guide.
    selection_rules: []const u8,

    pub const json_field_names = .{
        .migration_project_identifier = "MigrationProjectIdentifier",
        .origin = "Origin",
        .selection_rules = "SelectionRules",
    };
};

pub const DescribeMetadataModelOutput = struct {
    /// The SQL text of the metadata model. This field might not be populated for
    /// some metadata models.
    definition: ?[]const u8 = null,

    /// The name of the metadata model.
    metadata_model_name: ?[]const u8 = null,

    /// The type of the metadata model.
    metadata_model_type: ?[]const u8 = null,

    /// A list of counterpart metadata models in the target. This field is populated
    /// only when Origin is SOURCE and after the object has been converted by DMS
    /// Schema Conversion.
    target_metadata_models: ?[]const MetadataModelReference = null,

    pub const json_field_names = .{
        .definition = "Definition",
        .metadata_model_name = "MetadataModelName",
        .metadata_model_type = "MetadataModelType",
        .target_metadata_models = "TargetMetadataModels",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMetadataModelInput, options: CallOptions) !DescribeMetadataModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMetadataModelInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeMetadataModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMetadataModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMetadataModelOutput, body, allocator);
}
