const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateDirectoryInput = struct {
    /// The name of the Directory. Should be unique per account, per
    /// region.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the published schema that will be copied
    /// into the
    /// data Directory. For more information, see arns.
    schema_arn: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .schema_arn = "SchemaArn",
    };
};

pub const CreateDirectoryOutput = struct {
    /// The ARN of the published schema in the Directory. Once a published
    /// schema is copied into the directory, it has its own ARN, which is referred
    /// to applied schema
    /// ARN. For more information, see arns.
    applied_schema_arn: []const u8,

    /// The ARN that is associated with the Directory. For more information,
    /// see arns.
    directory_arn: []const u8,

    /// The name of the Directory.
    name: []const u8,

    /// The root object node of the created directory.
    object_identifier: []const u8,

    pub const json_field_names = .{
        .applied_schema_arn = "AppliedSchemaArn",
        .directory_arn = "DirectoryArn",
        .name = "Name",
        .object_identifier = "ObjectIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDirectoryInput, options: CallOptions) !CreateDirectoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "clouddirectory", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDirectoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/directory/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-data-partition", input.schema_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDirectoryOutput {
    const result: CreateDirectoryOutput = try aws.json.parseJsonObject(
        CreateDirectoryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
