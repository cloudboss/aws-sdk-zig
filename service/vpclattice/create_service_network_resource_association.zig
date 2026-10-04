const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceNetworkResourceAssociationStatus = @import("service_network_resource_association_status.zig").ServiceNetworkResourceAssociationStatus;

pub const CreateServiceNetworkResourceAssociationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client token and parameters, the retry succeeds
    /// without performing any actions. If the parameters aren't identical, the
    /// retry fails.
    client_token: ?[]const u8 = null,

    /// Indicates if private DNS is enabled for the service network resource
    /// association.
    private_dns_enabled: ?bool = null,

    /// The ID of the resource configuration to associate with the service network.
    resource_configuration_identifier: []const u8,

    /// The ID of the service network to associate with the resource configuration.
    service_network_identifier: []const u8,

    /// A key-value pair to associate with a resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .private_dns_enabled = "privateDnsEnabled",
        .resource_configuration_identifier = "resourceConfigurationIdentifier",
        .service_network_identifier = "serviceNetworkIdentifier",
        .tags = "tags",
    };
};

pub const CreateServiceNetworkResourceAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: ?[]const u8 = null,

    /// The ID of the account that created the association.
    created_by: ?[]const u8 = null,

    /// The ID of the association.
    id: ?[]const u8 = null,

    /// Indicates if private DNS is is enabled for the service network resource
    /// association.
    private_dns_enabled: ?bool = null,

    /// The status of the association.
    status: ?ServiceNetworkResourceAssociationStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_by = "createdBy",
        .id = "id",
        .private_dns_enabled = "privateDnsEnabled",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceNetworkResourceAssociationInput, options: CallOptions) !CreateServiceNetworkResourceAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceNetworkResourceAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/servicenetworkresourceassociations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.private_dns_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"privateDnsEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceConfigurationIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.resource_configuration_identifier), input.resource_configuration_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceNetworkIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.service_network_identifier), input.service_network_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceNetworkResourceAssociationOutput {
    var result: CreateServiceNetworkResourceAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateServiceNetworkResourceAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
