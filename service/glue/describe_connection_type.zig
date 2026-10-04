const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Property = @import("property.zig").Property;
const AuthConfiguration = @import("auth_configuration.zig").AuthConfiguration;
const Capabilities = @import("capabilities.zig").Capabilities;
const ComputeEnvironmentConfiguration = @import("compute_environment_configuration.zig").ComputeEnvironmentConfiguration;
const RestConfiguration = @import("rest_configuration.zig").RestConfiguration;

pub const DescribeConnectionTypeInput = struct {
    /// The name of the connection type to be described.
    connection_type: []const u8,

    pub const json_field_names = .{
        .connection_type = "ConnectionType",
    };
};

pub const DescribeConnectionTypeOutput = struct {
    /// Connection properties specific to the Athena compute environment.
    athena_connection_properties: ?[]const aws.map.MapEntry(Property) = null,

    /// The type of authentication used for the connection.
    authentication_configuration: ?AuthConfiguration = null,

    /// The supported authentication types, data interface types (compute
    /// environments), and data operations of the connector.
    capabilities: ?Capabilities = null,

    /// The compute environments that are supported by the connection.
    compute_environment_configurations: ?[]const aws.map.MapEntry(ComputeEnvironmentConfiguration) = null,

    /// Returns properties that can be set when creating a connection in the
    /// `ConnectionInput.ConnectionProperties`. `ConnectionOptions` defines
    /// parameters that can be set in a Spark ETL script in the connection options
    /// map passed to a dataframe.
    connection_options: ?[]const aws.map.MapEntry(Property) = null,

    /// Connection properties which are common across compute environments.
    connection_properties: ?[]const aws.map.MapEntry(Property) = null,

    /// The name of the connection type.
    connection_type: ?[]const u8 = null,

    /// A description of the connection type.
    description: ?[]const u8 = null,

    /// Physical requirements for a connection, such as VPC, Subnet and Security
    /// Group specifications.
    physical_connection_requirements: ?[]const aws.map.MapEntry(Property) = null,

    /// Connection properties specific to the Python compute environment.
    python_connection_properties: ?[]const aws.map.MapEntry(Property) = null,

    /// HTTP request and response configuration, validation endpoint, and entity
    /// configurations for REST based data source.
    rest_configuration: ?RestConfiguration = null,

    /// Connection properties specific to the Spark compute environment.
    spark_connection_properties: ?[]const aws.map.MapEntry(Property) = null,

    pub const json_field_names = .{
        .athena_connection_properties = "AthenaConnectionProperties",
        .authentication_configuration = "AuthenticationConfiguration",
        .capabilities = "Capabilities",
        .compute_environment_configurations = "ComputeEnvironmentConfigurations",
        .connection_options = "ConnectionOptions",
        .connection_properties = "ConnectionProperties",
        .connection_type = "ConnectionType",
        .description = "Description",
        .physical_connection_requirements = "PhysicalConnectionRequirements",
        .python_connection_properties = "PythonConnectionProperties",
        .rest_configuration = "RestConfiguration",
        .spark_connection_properties = "SparkConnectionProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectionTypeInput, options: CallOptions) !DescribeConnectionTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectionTypeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.DescribeConnectionType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectionTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeConnectionTypeOutput, body, allocator);
}
