const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateSecurityConfigurationInput = struct {
    /// The name of the security configuration.
    name: []const u8,

    /// The security configuration details in JSON format. For JSON parameters and
    /// examples, see
    /// [Use Security
    /// Configurations to Set Up Cluster
    /// Security](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-security-configurations.html) in the *Amazon EMR
    /// Management Guide*.
    security_configuration: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .security_configuration = "SecurityConfiguration",
    };
};

pub const CreateSecurityConfigurationOutput = struct {
    /// The date and time the security configuration was created.
    creation_date_time: i64,

    /// The name of the security configuration.
    name: []const u8,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSecurityConfigurationInput, options: CallOptions) !CreateSecurityConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSecurityConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.CreateSecurityConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSecurityConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateSecurityConfigurationOutput, body, allocator);
}
