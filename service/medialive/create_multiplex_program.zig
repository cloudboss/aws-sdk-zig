const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultiplexProgramSettings = @import("multiplex_program_settings.zig").MultiplexProgramSettings;
const MultiplexProgram = @import("multiplex_program.zig").MultiplexProgram;

pub const CreateMultiplexProgramInput = struct {
    /// ID of the multiplex where the program is to be created.
    multiplex_id: []const u8,

    /// The settings for this multiplex program.
    multiplex_program_settings: MultiplexProgramSettings,

    /// Name of multiplex program.
    program_name: []const u8,

    /// Unique request ID. This prevents retries from creating multiple
    /// resources.
    request_id: []const u8,

    pub const json_field_names = .{
        .multiplex_id = "MultiplexId",
        .multiplex_program_settings = "MultiplexProgramSettings",
        .program_name = "ProgramName",
        .request_id = "RequestId",
    };
};

pub const CreateMultiplexProgramOutput = struct {
    /// The newly created multiplex program.
    multiplex_program: ?MultiplexProgram = null,

    pub const json_field_names = .{
        .multiplex_program = "MultiplexProgram",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMultiplexProgramInput, options: CallOptions) !CreateMultiplexProgramOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMultiplexProgramInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/multiplexes/");
    try path_buf.appendSlice(allocator, input.multiplex_id);
    try path_buf.appendSlice(allocator, "/programs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MultiplexProgramSettings\":");
    try aws.json.writeValue(@TypeOf(input.multiplex_program_settings), input.multiplex_program_settings, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProgramName\":");
    try aws.json.writeValue(@TypeOf(input.program_name), input.program_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RequestId\":");
    try aws.json.writeValue(@TypeOf(input.request_id), input.request_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMultiplexProgramOutput {
    const result: CreateMultiplexProgramOutput = try aws.json.parseJsonObject(
        CreateMultiplexProgramOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
