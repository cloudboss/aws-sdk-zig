const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FieldDefinition = @import("field_definition.zig").FieldDefinition;

pub const CreateTypeInput = struct {
    /// The field definitions, consisting of names and types, that define this type.
    field_definitions: []const FieldDefinition,

    /// The name of the keyspace.
    keyspace_name: []const u8,

    /// The name of the user-defined type.
    ///
    /// UDT names must contain 48 characters or less, must begin with an alphabetic
    /// character, and can only contain alpha-numeric characters and underscores.
    /// Amazon Keyspaces converts upper case characters automatically into lower
    /// case characters.
    ///
    /// Alternatively, you can declare a UDT name in double quotes. When declaring a
    /// UDT name inside double quotes, Amazon Keyspaces preserves upper casing and
    /// allows special characters.
    ///
    /// You can also use double quotes as part of the name when you create the UDT,
    /// but you must escape each double quote character with an additional double
    /// quote character.
    type_name: []const u8,

    pub const json_field_names = .{
        .field_definitions = "fieldDefinitions",
        .keyspace_name = "keyspaceName",
        .type_name = "typeName",
    };
};

pub const CreateTypeOutput = struct {
    /// The unique identifier of the keyspace that contains the new type in the
    /// format of an Amazon Resource Name (ARN).
    keyspace_arn: []const u8,

    /// The formatted name of the user-defined type that was created. Note that
    /// Amazon Keyspaces requires the formatted name of the type for other
    /// operations, for example `GetType`.
    type_name: []const u8,

    pub const json_field_names = .{
        .keyspace_arn = "keyspaceArn",
        .type_name = "typeName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTypeInput, options: CallOptions) !CreateTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTypeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesService.CreateType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTypeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateTypeOutput, body, allocator);
}
