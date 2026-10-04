const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngestProtocol = @import("ingest_protocol.zig").IngestProtocol;
const IngestConfiguration = @import("ingest_configuration.zig").IngestConfiguration;

pub const CreateIngestConfigurationInput = struct {
    /// Application-provided attributes to store in the IngestConfiguration and
    /// attach to a stage. Map keys and values can contain UTF-8 encoded text. The
    /// maximum length of this field is 1 KB total.
    /// *This field is exposed to all stage participants and should not be used for
    /// personally identifying, confidential, or sensitive information.*
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// Type of ingest protocol that the user employs to broadcast. If this is set
    /// to `RTMP`, `insecureIngest` must be set to `true`.
    ingest_protocol: IngestProtocol,

    /// Whether the stage allows insecure RTMP ingest. This must be set to `true`,
    /// if `ingestProtocol` is set to `RTMP`. Default: `false`.
    insecure_ingest: ?bool = null,

    /// Optional name that can be specified for the IngestConfiguration being
    /// created.
    name: ?[]const u8 = null,

    /// Indicates whether redundant ingest is enabled for the ingest configuration.
    /// Default: `false`.
    redundant_ingest: ?bool = null,

    /// ARN of the stage with which the IngestConfiguration is associated.
    stage_arn: ?[]const u8 = null,

    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html)
    /// in *Tagging AWS Resources and Tag Editor* for details, including
    /// restrictions that apply to tags and "Tag naming
    /// limits and requirements"; Amazon IVS has no constraints on tags beyond what
    /// is documented
    /// there.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Customer-assigned name to help identify the participant using the
    /// IngestConfiguration; this can be used to link a participant to a user in the
    /// customer’s own systems. This can be any UTF-8 encoded text.
    /// *This field is exposed to all stage participants and should not be used for
    /// personally identifying, confidential, or sensitive information.*
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .ingest_protocol = "ingestProtocol",
        .insecure_ingest = "insecureIngest",
        .name = "name",
        .redundant_ingest = "redundantIngest",
        .stage_arn = "stageArn",
        .tags = "tags",
        .user_id = "userId",
    };
};

pub const CreateIngestConfigurationOutput = struct {
    /// The IngestConfiguration that was created.
    ingest_configuration: ?IngestConfiguration = null,

    pub const json_field_names = .{
        .ingest_configuration = "ingestConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIngestConfigurationInput, options: CallOptions) !CreateIngestConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIngestConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateIngestConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ingestProtocol\":");
    try aws.json.writeValue(@TypeOf(input.ingest_protocol), input.ingest_protocol, allocator, &body_buf);
    has_prev = true;
    if (input.insecure_ingest) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"insecureIngest\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.redundant_ingest) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"redundantIngest\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stage_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stageArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIngestConfigurationOutput {
    var result: CreateIngestConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateIngestConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
