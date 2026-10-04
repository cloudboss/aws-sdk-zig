const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FieldDefinition = @import("field_definition.zig").FieldDefinition;
const TypeStatus = @import("type_status.zig").TypeStatus;

pub const GetTypeInput = struct {
    /// The name of the keyspace that contains this type.
    keyspace_name: []const u8,

    /// The formatted name of the type. For example, if the name of the type was
    /// created without double quotes, Amazon Keyspaces saved the name in lower-case
    /// characters. If the name was created in double quotes, you must use double
    /// quotes to specify the type name.
    type_name: []const u8,

    pub const json_field_names = .{
        .keyspace_name = "keyspaceName",
        .type_name = "typeName",
    };
};

pub const GetTypeOutput = struct {
    /// The types that use this type.
    direct_parent_types: ?[]const []const u8 = null,

    /// The tables that use this type.
    direct_referring_tables: ?[]const []const u8 = null,

    /// The names and types that define this type.
    field_definitions: ?[]const FieldDefinition = null,

    /// The unique identifier of the keyspace that contains this type in the format
    /// of an Amazon Resource Name (ARN).
    keyspace_arn: []const u8,

    /// The name of the keyspace that contains this type.
    keyspace_name: []const u8,

    /// The timestamp that shows when this type was last modified.
    last_modified_timestamp: ?i64 = null,

    /// The level of nesting implemented for this type.
    max_nesting_depth: ?i32 = null,

    /// The status of this type.
    status: ?TypeStatus = null,

    /// The name of the type.
    type_name: []const u8,

    pub const json_field_names = .{
        .direct_parent_types = "directParentTypes",
        .direct_referring_tables = "directReferringTables",
        .field_definitions = "fieldDefinitions",
        .keyspace_arn = "keyspaceArn",
        .keyspace_name = "keyspaceName",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .max_nesting_depth = "maxNestingDepth",
        .status = "status",
        .type_name = "typeName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTypeInput, options: CallOptions) !GetTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cassandra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cassandra", "Keyspaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesService.GetType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTypeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetTypeOutput, body, allocator);
}
