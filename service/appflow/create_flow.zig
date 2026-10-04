const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationFlowConfig = @import("destination_flow_config.zig").DestinationFlowConfig;
const MetadataCatalogConfig = @import("metadata_catalog_config.zig").MetadataCatalogConfig;
const SourceFlowConfig = @import("source_flow_config.zig").SourceFlowConfig;
const Task = @import("task.zig").Task;
const TriggerConfig = @import("trigger_config.zig").TriggerConfig;
const FlowStatus = @import("flow_status.zig").FlowStatus;

pub const CreateFlowInput = struct {
    /// The `clientToken` parameter is an idempotency token. It ensures that your
    /// `CreateFlow` request completes only once. You choose the value to pass. For
    /// example, if you don't receive a response from your request, you can safely
    /// retry the request
    /// with the same `clientToken` parameter value.
    ///
    /// If you omit a `clientToken` value, the Amazon Web Services SDK that you are
    /// using inserts a value for you. This way, the SDK can safely retry requests
    /// multiple times
    /// after a network error. You must provide your own value for other use cases.
    ///
    /// If you specify input parameters that differ from your first request, an
    /// error occurs. If
    /// you use a different value for `clientToken`, Amazon AppFlow considers it a
    /// new
    /// call to `CreateFlow`. The token is active for 8 hours.
    client_token: ?[]const u8 = null,

    /// A description of the flow you want to create.
    description: ?[]const u8 = null,

    /// The configuration that controls how Amazon AppFlow places data in the
    /// destination
    /// connector.
    destination_flow_config_list: []const DestinationFlowConfig,

    /// The specified name of the flow. Spaces are not allowed. Use underscores (_)
    /// or hyphens
    /// (-) only.
    flow_name: []const u8,

    /// The ARN (Amazon Resource Name) of the Key Management Service (KMS) key you
    /// provide for
    /// encryption. This is required if you do not want to use the Amazon
    /// AppFlow-managed KMS
    /// key. If you don't provide anything here, Amazon AppFlow uses the Amazon
    /// AppFlow-managed KMS key.
    kms_arn: ?[]const u8 = null,

    /// Specifies the configuration that Amazon AppFlow uses when it catalogs the
    /// data that's
    /// transferred by the associated flow. When Amazon AppFlow catalogs the data
    /// from a flow, it
    /// stores metadata in a data catalog.
    metadata_catalog_config: ?MetadataCatalogConfig = null,

    /// The configuration that controls how Amazon AppFlow retrieves data from the
    /// source
    /// connector.
    source_flow_config: SourceFlowConfig,

    /// The tags used to organize, track, or control access for your flow.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of tasks that Amazon AppFlow performs while transferring the data in
    /// the flow
    /// run.
    tasks: []const Task,

    /// The trigger settings that determine how and when the flow runs.
    trigger_config: TriggerConfig,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .destination_flow_config_list = "destinationFlowConfigList",
        .flow_name = "flowName",
        .kms_arn = "kmsArn",
        .metadata_catalog_config = "metadataCatalogConfig",
        .source_flow_config = "sourceFlowConfig",
        .tags = "tags",
        .tasks = "tasks",
        .trigger_config = "triggerConfig",
    };
};

pub const CreateFlowOutput = struct {
    /// The flow's Amazon Resource Name (ARN).
    flow_arn: ?[]const u8 = null,

    /// Indicates the current status of the flow.
    flow_status: ?FlowStatus = null,

    pub const json_field_names = .{
        .flow_arn = "flowArn",
        .flow_status = "flowStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFlowInput, options: CallOptions) !CreateFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appflow", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/create-flow";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationFlowConfigList\":");
    try aws.json.writeValue(@TypeOf(input.destination_flow_config_list), input.destination_flow_config_list, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"flowName\":");
    try aws.json.writeValue(@TypeOf(input.flow_name), input.flow_name, allocator, &body_buf);
    has_prev = true;
    if (input.kms_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata_catalog_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadataCatalogConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceFlowConfig\":");
    try aws.json.writeValue(@TypeOf(input.source_flow_config), input.source_flow_config, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"tasks\":");
    try aws.json.writeValue(@TypeOf(input.tasks), input.tasks, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"triggerConfig\":");
    try aws.json.writeValue(@TypeOf(input.trigger_config), input.trigger_config, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFlowOutput {
    const result: CreateFlowOutput = try aws.json.parseJsonObject(
        CreateFlowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
