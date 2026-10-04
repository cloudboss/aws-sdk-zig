const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BackintConfig = @import("backint_config.zig").BackintConfig;
const ApplicationCredential = @import("application_credential.zig").ApplicationCredential;

pub const UpdateApplicationSettingsInput = struct {
    /// The ID of the application.
    application_id: []const u8,

    /// Installation of AWS Backint Agent for SAP HANA.
    backint: ?BackintConfig = null,

    /// The credentials to be added or updated.
    credentials_to_add_or_update: ?[]const ApplicationCredential = null,

    /// The credentials to be removed.
    credentials_to_remove: ?[]const ApplicationCredential = null,

    /// The Amazon Resource Name of the SAP HANA database that replaces the current
    /// SAP HANA connection with the SAP_ABAP application.
    database_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .backint = "Backint",
        .credentials_to_add_or_update = "CredentialsToAddOrUpdate",
        .credentials_to_remove = "CredentialsToRemove",
        .database_arn = "DatabaseArn",
    };
};

pub const UpdateApplicationSettingsOutput = struct {
    /// The update message.
    message: ?[]const u8 = null,

    /// The IDs of the operations.
    operation_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .operation_ids = "OperationIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationSettingsInput, options: CallOptions) !UpdateApplicationSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-sap", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-sap", "Ssm Sap", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-application-settings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApplicationId\":");
    try aws.json.writeValue(@TypeOf(input.application_id), input.application_id, allocator, &body_buf);
    has_prev = true;
    if (input.backint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Backint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.credentials_to_add_or_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CredentialsToAddOrUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.credentials_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CredentialsToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.database_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DatabaseArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationSettingsOutput {
    const result: UpdateApplicationSettingsOutput = try aws.json.parseJsonObject(
        UpdateApplicationSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
