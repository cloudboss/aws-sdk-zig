const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainNameConfiguration = @import("domain_name_configuration.zig").DomainNameConfiguration;
const MutualTlsAuthenticationInput = @import("mutual_tls_authentication_input.zig").MutualTlsAuthenticationInput;
const RoutingMode = @import("routing_mode.zig").RoutingMode;
const MutualTlsAuthentication = @import("mutual_tls_authentication.zig").MutualTlsAuthentication;

pub const CreateDomainNameInput = struct {
    /// The domain name.
    domain_name: []const u8,

    /// The domain name configurations.
    domain_name_configurations: ?[]const DomainNameConfiguration = null,

    /// The mutual TLS authentication configuration for a custom domain name.
    mutual_tls_authentication: ?MutualTlsAuthenticationInput = null,

    /// The routing mode.
    routing_mode: ?RoutingMode = null,

    /// The collection of tags associated with a domain name.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .domain_name_configurations = "DomainNameConfigurations",
        .mutual_tls_authentication = "MutualTlsAuthentication",
        .routing_mode = "RoutingMode",
        .tags = "Tags",
    };
};

pub const CreateDomainNameOutput = struct {
    /// The API mapping selection expression.
    api_mapping_selection_expression: ?[]const u8 = null,

    /// The name of the DomainName resource.
    domain_name: ?[]const u8 = null,

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainNameInput, options: CallOptions) !CreateDomainNameOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainNameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/domainnames";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DomainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;
    if (input.domain_name_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DomainNameConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.mutual_tls_authentication) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MutualTlsAuthentication\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.routing_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RoutingMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainNameOutput {
    var result: CreateDomainNameOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDomainNameOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
