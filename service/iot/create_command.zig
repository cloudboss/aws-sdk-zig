const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommandParameter = @import("command_parameter.zig").CommandParameter;
const CommandNamespace = @import("command_namespace.zig").CommandNamespace;
const CommandPayload = @import("command_payload.zig").CommandPayload;
const CommandPreprocessor = @import("command_preprocessor.zig").CommandPreprocessor;
const Tag = @import("tag.zig").Tag;

pub const CreateCommandInput = struct {
    /// A unique identifier for the command. We recommend using UUID. Alpha-numeric
    /// characters, hyphens, and underscores are valid for use here.
    command_id: []const u8,

    /// A short text decription of the command.
    description: ?[]const u8 = null,

    /// The user-friendly name in the console for the command. This name doesn't
    /// have to be
    /// unique. You can update the user-friendly name after you define it.
    display_name: ?[]const u8 = null,

    /// A list of parameters that are used by `StartCommandExecution` API for
    /// execution payload generation.
    mandatory_parameters: ?[]const CommandParameter = null,

    /// The namespace of the command. The MQTT reserved topics and validations will
    /// be used
    /// for command executions according to the namespace setting.
    namespace: ?CommandNamespace = null,

    /// The payload object for the static command.
    ///
    /// You can upload a static payload file from your local storage that contains
    /// the
    /// instructions for the device to process. The payload file can use any format.
    /// To
    /// make sure that the device correctly interprets the payload, we recommend you
    /// to
    /// specify the payload content type.
    payload: ?CommandPayload = null,

    /// The payload template for the dynamic command.
    ///
    /// This parameter is required for dynamic commands where the
    /// command execution placeholders are supplied either from
    /// `mandatoryParameters` or when
    /// `StartCommandExecution` is invoked.
    payload_template: ?[]const u8 = null,

    /// Configuration that determines how `payloadTemplate` is processed to generate
    /// command execution payload.
    ///
    /// This parameter is required for dynamic commands, along with
    /// `payloadTemplate`,
    /// and `mandatoryParameters`.
    preprocessor: ?CommandPreprocessor = null,

    /// The IAM role that you must provide when using the `AWS-IoT-FleetWise`
    /// namespace.
    /// The role grants IoT Device Management the permission to access IoT FleetWise
    /// resources
    /// for generating the payload for the command. This field is not supported when
    /// you use the
    /// `AWS-IoT` namespace.
    role_arn: ?[]const u8 = null,

    /// Name-value pairs that are used as metadata to manage a command.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .command_id = "commandId",
        .description = "description",
        .display_name = "displayName",
        .mandatory_parameters = "mandatoryParameters",
        .namespace = "namespace",
        .payload = "payload",
        .payload_template = "payloadTemplate",
        .preprocessor = "preprocessor",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateCommandOutput = struct {
    /// The Amazon Resource Number (ARN) of the command. For example,
    /// `arn:aws:iot:::command/`
    command_arn: ?[]const u8 = null,

    /// The unique identifier for the command.
    command_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_arn = "commandArn",
        .command_id = "commandId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCommandInput, options: CallOptions) !CreateCommandOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCommandInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/commands/");
    try path_buf.appendSlice(allocator, input.command_id);
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
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.mandatory_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mandatoryParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.namespace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"namespace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.payload) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"payload\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.payload_template) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"payloadTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.preprocessor) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"preprocessor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCommandOutput {
    var result: CreateCommandOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCommandOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
