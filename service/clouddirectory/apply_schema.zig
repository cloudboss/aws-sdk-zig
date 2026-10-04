const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ApplySchemaInput = struct {
    /// The Amazon Resource Name (ARN) that is associated with the Directory
    /// into which the schema is copied. For more information, see arns.
    directory_arn: []const u8,

    /// Published schema Amazon Resource Name (ARN) that needs to be copied. For
    /// more
    /// information, see arns.
    published_schema_arn: []const u8,

    pub const json_field_names = .{
        .directory_arn = "DirectoryArn",
        .published_schema_arn = "PublishedSchemaArn",
    };
};

pub const ApplySchemaOutput = struct {
    /// The applied schema ARN that is associated with the copied schema in the
    /// Directory. You can use this ARN to describe the schema information applied
    /// on
    /// this directory. For more information, see arns.
    applied_schema_arn: ?[]const u8 = null,

    /// The ARN that is associated with the Directory. For more information,
    /// see arns.
    directory_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .applied_schema_arn = "AppliedSchemaArn",
        .directory_arn = "DirectoryArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ApplySchemaInput, options: CallOptions) !ApplySchemaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ApplySchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/schema/apply";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PublishedSchemaArn\":");
    try aws.json.writeValue(@TypeOf(input.published_schema_arn), input.published_schema_arn, allocator, &body_buf);
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
    try request.headers.put(allocator, "x-amz-data-partition", input.directory_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ApplySchemaOutput {
    var result: ApplySchemaOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ApplySchemaOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
