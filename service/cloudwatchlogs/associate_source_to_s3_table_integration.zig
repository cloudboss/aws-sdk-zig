const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSource = @import("data_source.zig").DataSource;

pub const AssociateSourceToS3TableIntegrationInput = struct {
    /// The data source to associate with the S3 Table Integration. Contains the
    /// name and type of
    /// the data source.
    data_source: DataSource,

    /// The Amazon Resource Name (ARN) of the S3 Table Integration to associate the
    /// data source
    /// with.
    integration_arn: []const u8,

    pub const json_field_names = .{
        .data_source = "dataSource",
        .integration_arn = "integrationArn",
    };
};

pub const AssociateSourceToS3TableIntegrationOutput = struct {
    /// The unique identifier for the association between the data source and S3
    /// Table
    /// Integration.
    identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateSourceToS3TableIntegrationInput, options: CallOptions) !AssociateSourceToS3TableIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateSourceToS3TableIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.AssociateSourceToS3TableIntegration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateSourceToS3TableIntegrationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociateSourceToS3TableIntegrationOutput, body, allocator);
}
