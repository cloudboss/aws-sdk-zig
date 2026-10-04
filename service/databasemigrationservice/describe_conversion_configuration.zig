const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeConversionConfigurationInput = struct {
    /// The name or Amazon Resource Name (ARN) for the schema conversion project to
    /// describe.
    migration_project_identifier: []const u8,

    pub const json_field_names = .{
        .migration_project_identifier = "MigrationProjectIdentifier",
    };
};

pub const DescribeConversionConfigurationOutput = struct {
    /// A JSON string that contains the schema conversion settings for the migration
    /// project.
    /// For the format and available settings, see
    /// [Specifying schema conversion
    /// settings for migration
    /// projects](https://docs.aws.amazon.com/dms/latest/userguide/schema-conversion-settings.html).
    conversion_configuration: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) for the schema conversion project.
    migration_project_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .conversion_configuration = "ConversionConfiguration",
        .migration_project_identifier = "MigrationProjectIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConversionConfigurationInput, options: CallOptions) !DescribeConversionConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConversionConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeConversionConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConversionConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeConversionConfigurationOutput, body, allocator);
}
