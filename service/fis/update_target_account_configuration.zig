const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TargetAccountConfiguration = @import("target_account_configuration.zig").TargetAccountConfiguration;

pub const UpdateTargetAccountConfigurationInput = struct {
    /// The Amazon Web Services account ID of the target account.
    account_id: []const u8,

    /// The description of the target account.
    description: ?[]const u8 = null,

    /// The ID of the experiment template.
    experiment_template_id: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role for the target account.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .description = "description",
        .experiment_template_id = "experimentTemplateId",
        .role_arn = "roleArn",
    };
};

pub const UpdateTargetAccountConfigurationOutput = struct {
    /// Information about the target account configuration.
    target_account_configuration: ?TargetAccountConfiguration = null,

    pub const json_field_names = .{
        .target_account_configuration = "targetAccountConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTargetAccountConfigurationInput, options: CallOptions) !UpdateTargetAccountConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTargetAccountConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fis", "fis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/experimentTemplates/");
    try path_buf.appendSlice(allocator, input.experiment_template_id);
    try path_buf.appendSlice(allocator, "/targetAccountConfigurations/");
    try path_buf.appendSlice(allocator, input.account_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTargetAccountConfigurationOutput {
    const result: UpdateTargetAccountConfigurationOutput = try aws.json.parseJsonObject(
        UpdateTargetAccountConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
