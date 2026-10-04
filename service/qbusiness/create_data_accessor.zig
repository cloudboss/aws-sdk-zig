const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionConfiguration = @import("action_configuration.zig").ActionConfiguration;
const DataAccessorAuthenticationDetail = @import("data_accessor_authentication_detail.zig").DataAccessorAuthenticationDetail;
const Tag = @import("tag.zig").Tag;

pub const CreateDataAccessorInput = struct {
    /// A list of action configurations specifying the allowed actions and any
    /// associated filters.
    action_configurations: []const ActionConfiguration,

    /// The unique identifier of the Amazon Q Business application.
    application_id: []const u8,

    /// The authentication configuration details for the data accessor. This
    /// specifies how the ISV will authenticate when accessing data through this
    /// data accessor.
    authentication_detail: ?DataAccessorAuthenticationDetail = null,

    /// A unique, case-sensitive identifier you provide to ensure idempotency of the
    /// request.
    client_token: ?[]const u8 = null,

    /// A friendly name for the data accessor.
    display_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role for the ISV that will be
    /// accessing the data.
    principal: []const u8,

    /// The tags to associate with the data accessor.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .action_configurations = "actionConfigurations",
        .application_id = "applicationId",
        .authentication_detail = "authenticationDetail",
        .client_token = "clientToken",
        .display_name = "displayName",
        .principal = "principal",
        .tags = "tags",
    };
};

pub const CreateDataAccessorOutput = struct {
    /// The Amazon Resource Name (ARN) of the created data accessor.
    data_accessor_arn: []const u8,

    /// The unique identifier of the created data accessor.
    data_accessor_id: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center application
    /// created for this data accessor.
    idc_application_arn: []const u8,

    pub const json_field_names = .{
        .data_accessor_arn = "dataAccessorArn",
        .data_accessor_id = "dataAccessorId",
        .idc_application_arn = "idcApplicationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataAccessorInput, options: CallOptions) !CreateDataAccessorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataAccessorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/dataaccessors");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actionConfigurations\":");
    try aws.json.writeValue(@TypeOf(input.action_configurations), input.action_configurations, allocator, &body_buf);
    has_prev = true;
    if (input.authentication_detail) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authenticationDetail\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"displayName\":");
    try aws.json.writeValue(@TypeOf(input.display_name), input.display_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"principal\":");
    try aws.json.writeValue(@TypeOf(input.principal), input.principal, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataAccessorOutput {
    var result: CreateDataAccessorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataAccessorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
