const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const RenditionConfiguration = @import("rendition_configuration.zig").RenditionConfiguration;
const ThumbnailConfiguration = @import("thumbnail_configuration.zig").ThumbnailConfiguration;
const RecordingConfiguration = @import("recording_configuration.zig").RecordingConfiguration;

pub const CreateRecordingConfigurationInput = struct {
    /// A complex type that contains a destination configuration for where recorded
    /// video will be stored.
    destination_configuration: DestinationConfiguration,

    /// Recording-configuration name. The value does not need to be unique.
    name: ?[]const u8 = null,

    /// If a broadcast disconnects and then reconnects within the specified
    /// interval, the multiple streams will be considered a single broadcast and
    /// merged together. Default: 0.
    recording_reconnect_window_seconds: ?i32 = null,

    /// Object that describes which renditions should be recorded for a stream.
    rendition_configuration: ?RenditionConfiguration = null,

    /// Array of 1-50 maps, each of the form `string:string (key:value)`. See [Best
    /// practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A complex type that allows you to enable/disable the recording of thumbnails
    /// for a live session and modify the interval at which thumbnails are generated
    /// for the live session.
    thumbnail_configuration: ?ThumbnailConfiguration = null,

    pub const json_field_names = .{
        .destination_configuration = "destinationConfiguration",
        .name = "name",
        .recording_reconnect_window_seconds = "recordingReconnectWindowSeconds",
        .rendition_configuration = "renditionConfiguration",
        .tags = "tags",
        .thumbnail_configuration = "thumbnailConfiguration",
    };
};

pub const CreateRecordingConfigurationOutput = struct {
    recording_configuration: ?RecordingConfiguration = null,

    pub const json_field_names = .{
        .recording_configuration = "recordingConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRecordingConfigurationInput, options: CallOptions) !CreateRecordingConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRecordingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateRecordingConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.destination_configuration), input.destination_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recording_reconnect_window_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recordingReconnectWindowSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.rendition_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"renditionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.thumbnail_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"thumbnailConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRecordingConfigurationOutput {
    const result: CreateRecordingConfigurationOutput = try aws.json.parseJsonObject(
        CreateRecordingConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
