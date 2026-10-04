const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DetectorModelDefinition = @import("detector_model_definition.zig").DetectorModelDefinition;
const EvaluationMethod = @import("evaluation_method.zig").EvaluationMethod;
const Tag = @import("tag.zig").Tag;
const DetectorModelConfiguration = @import("detector_model_configuration.zig").DetectorModelConfiguration;

pub const CreateDetectorModelInput = struct {
    /// Information that defines how the detectors operate.
    detector_model_definition: DetectorModelDefinition,

    /// A brief description of the detector model.
    detector_model_description: ?[]const u8 = null,

    /// The name of the detector model.
    detector_model_name: []const u8,

    /// Information about the order in which events are evaluated and how actions
    /// are executed.
    evaluation_method: ?EvaluationMethod = null,

    /// The input attribute key used to identify a device or system to create a
    /// detector (an
    /// instance of the detector model) and then to route each input received to the
    /// appropriate
    /// detector (instance). This parameter uses a JSON-path expression in the
    /// message payload of each
    /// input to specify the attribute-value pair that is used to identify the
    /// device associated with
    /// the input.
    key: ?[]const u8 = null,

    /// The ARN of the role that grants permission to AWS IoT Events to perform its
    /// operations.
    role_arn: []const u8,

    /// Metadata that can be used to manage the detector model.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .detector_model_definition = "detectorModelDefinition",
        .detector_model_description = "detectorModelDescription",
        .detector_model_name = "detectorModelName",
        .evaluation_method = "evaluationMethod",
        .key = "key",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateDetectorModelOutput = struct {
    /// Information about how the detector model is configured.
    detector_model_configuration: ?DetectorModelConfiguration = null,

    pub const json_field_names = .{
        .detector_model_configuration = "detectorModelConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDetectorModelInput, options: CallOptions) !CreateDetectorModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotevents", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDetectorModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotevents", "IoT Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/detector-models";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"detectorModelDefinition\":");
    try aws.json.writeValue(@TypeOf(input.detector_model_definition), input.detector_model_definition, allocator, &body_buf);
    has_prev = true;
    if (input.detector_model_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"detectorModelDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"detectorModelName\":");
    try aws.json.writeValue(@TypeOf(input.detector_model_name), input.detector_model_name, allocator, &body_buf);
    has_prev = true;
    if (input.evaluation_method) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evaluationMethod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"key\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDetectorModelOutput {
    var result: CreateDetectorModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDetectorModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
