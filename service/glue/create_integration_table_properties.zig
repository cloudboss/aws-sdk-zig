const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceTableConfig = @import("source_table_config.zig").SourceTableConfig;
const TargetTableConfig = @import("target_table_config.zig").TargetTableConfig;

pub const CreateIntegrationTablePropertiesInput = struct {
    /// The Amazon Resource Name (ARN) of the target table for which to create
    /// integration table properties. Currently, this API only supports creating
    /// integration table properties for target tables, and the provided ARN should
    /// be the ARN of the target table in the Glue Data Catalog. Support for
    /// creating integration table properties for source connections (using the
    /// connection ARN) is not yet implemented and will be added in a future
    /// release.
    resource_arn: []const u8,

    /// A structure for the source table configuration. See the `SourceTableConfig`
    /// structure to see list of supported source properties.
    source_table_config: ?SourceTableConfig = null,

    /// The name of the table to be replicated.
    table_name: []const u8,

    /// A structure for the target table configuration.
    target_table_config: ?TargetTableConfig = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .source_table_config = "SourceTableConfig",
        .table_name = "TableName",
        .target_table_config = "TargetTableConfig",
    };
};

pub const CreateIntegrationTablePropertiesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntegrationTablePropertiesInput, options: CallOptions) !CreateIntegrationTablePropertiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIntegrationTablePropertiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateIntegrationTableProperties");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIntegrationTablePropertiesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
