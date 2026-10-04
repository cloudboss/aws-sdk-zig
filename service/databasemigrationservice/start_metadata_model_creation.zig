const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataModelProperties = @import("metadata_model_properties.zig").MetadataModelProperties;

pub const StartMetadataModelCreationInput = struct {
    /// The name of the metadata model.
    metadata_model_name: []const u8,

    /// The migration project name or Amazon Resource Name (ARN).
    migration_project_identifier: []const u8,

    /// The properties of metadata model in JSON format. This object is a Union.
    /// Only one member of this object can be specified or returned.
    properties: MetadataModelProperties,

    /// The JSON string that specifies the location where the metadata model will be
    /// created. Selection rules must specify a single schema. For more information,
    /// see Selection Rules in the DMS User Guide.
    selection_rules: []const u8,

    pub const json_field_names = .{
        .metadata_model_name = "MetadataModelName",
        .migration_project_identifier = "MigrationProjectIdentifier",
        .properties = "Properties",
        .selection_rules = "SelectionRules",
    };
};

pub const StartMetadataModelCreationOutput = struct {
    /// The identifier for the metadata model creation operation.
    request_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .request_identifier = "RequestIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMetadataModelCreationInput, options: CallOptions) !StartMetadataModelCreationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMetadataModelCreationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.StartMetadataModelCreation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMetadataModelCreationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMetadataModelCreationOutput, body, allocator);
}
