const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PublishSchemaInput = struct {
    /// The Amazon Resource Name (ARN) that is associated with the development
    /// schema. For
    /// more information, see arns.
    development_schema_arn: []const u8,

    /// The minor version under which the schema will be published. This parameter
    /// is recommended. Schemas have both a major and minor version associated with
    /// them.
    minor_version: ?[]const u8 = null,

    /// The new name under which the schema will be published. If this is not
    /// provided, the
    /// development schema is considered.
    name: ?[]const u8 = null,

    /// The major version under which the schema will be published. Schemas have
    /// both a major and minor version associated with them.
    version: []const u8,

    pub const json_field_names = .{
        .development_schema_arn = "DevelopmentSchemaArn",
        .minor_version = "MinorVersion",
        .name = "Name",
        .version = "Version",
    };
};

pub const PublishSchemaOutput = struct {
    /// The ARN that is associated with the published schema. For more information,
    /// see arns.
    published_schema_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .published_schema_arn = "PublishedSchemaArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishSchemaInput, options: CallOptions) !PublishSchemaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishSchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/schema/publish";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.minor_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MinorVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Version\":");
    try aws.json.writeValue(@TypeOf(input.version), input.version, allocator, &body_buf);
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
    try request.headers.put(allocator, "x-amz-data-partition", input.development_schema_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishSchemaOutput {
    var result: PublishSchemaOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PublishSchemaOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
