const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Architecture = @import("architecture.zig").Architecture;
const Runtime = @import("runtime.zig").Runtime;
const LayerVersionContentOutput = @import("layer_version_content_output.zig").LayerVersionContentOutput;

pub const GetLayerVersionByArnInput = struct {
    /// The ARN of the layer version.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const GetLayerVersionByArnOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLayerVersionByArnInput, options: CallOptions) !GetLayerVersionByArnOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLayerVersionByArnInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2018-10-31/layers";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "find=LayerVersion");
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "Arn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLayerVersionByArnOutput {
    var result: GetLayerVersionByArnOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetLayerVersionByArnOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
