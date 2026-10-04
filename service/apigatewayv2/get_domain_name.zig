const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainNameConfiguration = @import("domain_name_configuration.zig").DomainNameConfiguration;
const MutualTlsAuthentication = @import("mutual_tls_authentication.zig").MutualTlsAuthentication;
const RoutingMode = @import("routing_mode.zig").RoutingMode;

pub const GetDomainNameInput = struct {
    /// The domain name.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const GetDomainNameOutput = struct {
    /// The API mapping selection expression.
    api_mapping_selection_expression: ?[]const u8 = null,

    /// The name of the DomainName resource.
    domain_name: ?[]const u8 = null,

    /// The ARN of the DomainName resource.
    domain_name_arn: ?[]const u8 = null,

    /// The domain name configurations.
    domain_name_configurations: ?[]const DomainNameConfiguration = null,

    /// The mutual TLS authentication configuration for a custom domain name.
    mutual_tls_authentication: ?MutualTlsAuthentication = null,

    /// The routing mode.
    routing_mode: ?RoutingMode = null,

    /// The collection of tags associated with a domain name.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .api_mapping_selection_expression = "ApiMappingSelectionExpression",
        .domain_name = "DomainName",
        .domain_name_arn = "DomainNameArn",
        .domain_name_configurations = "DomainNameConfigurations",
        .mutual_tls_authentication = "MutualTlsAuthentication",
        .routing_mode = "RoutingMode",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainNameInput, options: CallOptions) !GetDomainNameOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainNameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domainnames/");
    try path_buf.appendSlice(allocator, input.domain_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainNameOutput {
    const result: GetDomainNameOutput = try aws.json.parseJsonObject(
        GetDomainNameOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
