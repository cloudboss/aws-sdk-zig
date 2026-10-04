const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputFormat = @import("input_format.zig").InputFormat;
const FormatOptions = @import("format_options.zig").FormatOptions;
const Input = @import("input.zig").Input;
const PathOptions = @import("path_options.zig").PathOptions;

pub const UpdateDatasetInput = struct {
    /// The file format of a dataset that is created from an Amazon S3 file or
    /// folder.
    format: ?InputFormat = null,

    format_options: ?FormatOptions = null,

    input: Input,

    /// The name of the dataset to be updated.
    name: []const u8,

    /// A set of options that defines how DataBrew interprets an Amazon S3 path of
    /// the dataset.
    path_options: ?PathOptions = null,

    pub const json_field_names = .{
        .format = "Format",
        .format_options = "FormatOptions",
        .input = "Input",
        .name = "Name",
        .path_options = "PathOptions",
    };
};

pub const UpdateDatasetOutput = struct {
    /// The name of the dataset that you updated.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDatasetInput, options: CallOptions) !UpdateDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "databrew", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Format\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.format_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FormatOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Input\":");
    try aws.json.writeValue(@TypeOf(input.input), input.input, allocator, &body_buf);
    has_prev = true;
    if (input.path_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PathOptions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDatasetOutput {
    var result: UpdateDatasetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDatasetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
