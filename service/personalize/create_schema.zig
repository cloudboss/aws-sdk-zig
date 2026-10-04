const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Domain = @import("domain.zig").Domain;

pub const CreateSchemaInput = struct {
    /// The domain for the schema. If you are creating a schema for a dataset in a
    /// Domain dataset group, specify
    /// the domain you chose when you created the Domain dataset group.
    domain: ?Domain = null,

    /// The name for the schema.
    name: []const u8,

    /// A schema in Avro JSON format.
    schema: []const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .name = "name",
        .schema = "schema",
    };
};

pub const CreateSchemaOutput = struct {
    /// The Amazon Resource Name (ARN) of the created schema.
    schema_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .schema_arn = "schemaArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSchemaInput, options: CallOptions) !CreateSchemaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.CreateSchema");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSchemaOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSchemaOutput, body, allocator);
}
