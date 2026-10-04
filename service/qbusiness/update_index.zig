const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexCapacityConfiguration = @import("index_capacity_configuration.zig").IndexCapacityConfiguration;
const DocumentAttributeConfiguration = @import("document_attribute_configuration.zig").DocumentAttributeConfiguration;

pub const UpdateIndexInput = struct {
    /// The identifier of the Amazon Q Business application connected to the index.
    application_id: []const u8,

    /// The storage capacity units you want to provision for your Amazon Q Business
    /// index. You can add and remove capacity to fit your usage needs.
    capacity_configuration: ?IndexCapacityConfiguration = null,

    /// The description of the Amazon Q Business index.
    description: ?[]const u8 = null,

    /// The name of the Amazon Q Business index.
    display_name: ?[]const u8 = null,

    /// Configuration information for document metadata or fields. Document metadata
    /// are fields or attributes associated with your documents. For example, the
    /// company department name associated with each document. For more information,
    /// see [Understanding document
    /// attributes](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/doc-attributes-types.html#doc-attributes).
    document_attribute_configurations: ?[]const DocumentAttributeConfiguration = null,

    /// The identifier of the Amazon Q Business index.
    index_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .capacity_configuration = "capacityConfiguration",
        .description = "description",
        .display_name = "displayName",
        .document_attribute_configurations = "documentAttributeConfigurations",
        .index_id = "indexId",
    };
};

pub const UpdateIndexOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIndexInput, options: CallOptions) !UpdateIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.capacity_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capacityConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.document_attribute_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"documentAttributeConfigurations\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIndexOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateIndexOutput = .{};

    return result;
}
