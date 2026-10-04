const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Architecture = @import("architecture.zig").Architecture;
const Runtime = @import("runtime.zig").Runtime;
const LayerVersionContentInput = @import("layer_version_content_input.zig").LayerVersionContentInput;
const LayerVersionContentOutput = @import("layer_version_content_output.zig").LayerVersionContentOutput;

pub const PublishLayerVersionInput = struct {
    /// A list of compatible [instruction set
    /// architectures](https://docs.aws.amazon.com/lambda/latest/dg/foundation-arch.html).
    compatible_architectures: ?[]const Architecture = null,

    /// A list of compatible [function
    /// runtimes](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html). Used for filtering with ListLayers and ListLayerVersions.
    ///
    /// The following list includes deprecated runtimes. For more information, see
    /// [Runtime deprecation
    /// policy](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtime-support-policy).
    compatible_runtimes: ?[]const Runtime = null,

    /// The function layer archive.
    content: LayerVersionContentInput,

    /// The description of the version.
    description: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) of the layer.
    layer_name: []const u8,

    /// The layer's software license. It can be any of the following:
    ///
    /// * An [SPDX license identifier](https://spdx.org/licenses/). For example,
    ///   `MIT`.
    /// * The URL of a license hosted on the internet. For example,
    ///   `https://opensource.org/licenses/MIT`.
    /// * The full text of the license.
    license_info: ?[]const u8 = null,

    pub const json_field_names = .{
        .compatible_architectures = "CompatibleArchitectures",
        .compatible_runtimes = "CompatibleRuntimes",
        .content = "Content",
        .description = "Description",
        .layer_name = "LayerName",
        .license_info = "LicenseInfo",
    };
};

pub const PublishLayerVersionOutput = struct {
    /// A list of compatible [instruction set
    /// architectures](https://docs.aws.amazon.com/lambda/latest/dg/foundation-arch.html).
    compatible_architectures: ?[]const Architecture = null,

    /// The layer's compatible runtimes.
    ///
    /// The following list includes deprecated runtimes. For more information, see
    /// [Runtime use after
    /// deprecation](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtime-deprecation-levels).
    ///
    /// For a list of all currently supported runtimes, see [Supported
    /// runtimes](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtimes-supported).
    compatible_runtimes: ?[]const Runtime = null,

    /// Details about the layer version.
    content: ?LayerVersionContentOutput = null,

    /// The date that the layer version was created, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    created_date: ?[]const u8 = null,

    /// The description of the version.
    description: ?[]const u8 = null,

    /// The ARN of the layer.
    layer_arn: ?[]const u8 = null,

    /// The ARN of the layer version.
    layer_version_arn: ?[]const u8 = null,

    /// The layer's software license.
    license_info: ?[]const u8 = null,

    /// The version number.
    version: ?i64 = null,

    pub const json_field_names = .{
        .compatible_architectures = "CompatibleArchitectures",
        .compatible_runtimes = "CompatibleRuntimes",
        .content = "Content",
        .created_date = "CreatedDate",
        .description = "Description",
        .layer_arn = "LayerArn",
        .layer_version_arn = "LayerVersionArn",
        .license_info = "LicenseInfo",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishLayerVersionInput, options: CallOptions) !PublishLayerVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishLayerVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2018-10-31/layers/");
    try path_buf.appendSlice(allocator, input.layer_name);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.compatible_architectures) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CompatibleArchitectures\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.compatible_runtimes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CompatibleRuntimes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.license_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LicenseInfo\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishLayerVersionOutput {
    var result: PublishLayerVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PublishLayerVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
