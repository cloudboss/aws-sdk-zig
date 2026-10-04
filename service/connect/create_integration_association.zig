const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationType = @import("integration_type.zig").IntegrationType;
const SourceType = @import("source_type.zig").SourceType;

pub const CreateIntegrationAssociationInput = struct {
    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The Amazon Resource Name (ARN) of the integration.
    ///
    /// When integrating with Amazon Web Services End User Messaging, the Amazon
    /// Connect and Amazon Web Services End
    /// User Messaging instances must be in the same account.
    integration_arn: []const u8,

    /// The type of information to be ingested.
    integration_type: IntegrationType,

    /// The name of the external application. This field is only required for the
    /// EVENT integration type.
    source_application_name: ?[]const u8 = null,

    /// The URL for the external application. This field is only required for the
    /// EVENT integration type.
    source_application_url: ?[]const u8 = null,

    /// The type of the data source. This field is only required for the EVENT
    /// integration type.
    source_type: ?SourceType = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .integration_arn = "IntegrationArn",
        .integration_type = "IntegrationType",
        .source_application_name = "SourceApplicationName",
        .source_application_url = "SourceApplicationUrl",
        .source_type = "SourceType",
        .tags = "Tags",
    };
};

pub const CreateIntegrationAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) for the association.
    integration_association_arn: ?[]const u8 = null,

    /// The identifier for the integration association.
    integration_association_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .integration_association_arn = "IntegrationAssociationArn",
        .integration_association_id = "IntegrationAssociationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntegrationAssociationInput, options: CallOptions) !CreateIntegrationAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIntegrationAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/integration-associations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IntegrationArn\":");
    try aws.json.writeValue(@TypeOf(input.integration_arn), input.integration_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IntegrationType\":");
    try aws.json.writeValue(@TypeOf(input.integration_type), input.integration_type, allocator, &body_buf);
    has_prev = true;
    if (input.source_application_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceApplicationName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_application_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceApplicationUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceType\":");
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIntegrationAssociationOutput {
    var result: CreateIntegrationAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateIntegrationAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
