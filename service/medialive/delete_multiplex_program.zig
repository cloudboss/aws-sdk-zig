const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultiplexProgramSettings = @import("multiplex_program_settings.zig").MultiplexProgramSettings;
const MultiplexProgramPacketIdentifiersMap = @import("multiplex_program_packet_identifiers_map.zig").MultiplexProgramPacketIdentifiersMap;
const MultiplexProgramPipelineDetail = @import("multiplex_program_pipeline_detail.zig").MultiplexProgramPipelineDetail;

pub const DeleteMultiplexProgramInput = struct {
    /// The ID of the multiplex that the program belongs to.
    multiplex_id: []const u8,

    /// The multiplex program name.
    program_name: []const u8,

    pub const json_field_names = .{
        .multiplex_id = "MultiplexId",
        .program_name = "ProgramName",
    };
};

pub const DeleteMultiplexProgramOutput = struct {
    /// The MediaLive channel associated with the program.
    channel_id: ?[]const u8 = null,

    /// The settings for this multiplex program.
    multiplex_program_settings: ?MultiplexProgramSettings = null,

    /// The packet identifier map for this multiplex program.
    packet_identifiers_map: ?MultiplexProgramPacketIdentifiersMap = null,

    /// Contains information about the current sources for the specified program in
    /// the specified multiplex. Keep in mind that each multiplex pipeline connects
    /// to both pipelines in a given source channel (the channel identified by the
    /// program). But only one of those channel pipelines is ever active at one
    /// time.
    pipeline_details: ?[]const MultiplexProgramPipelineDetail = null,

    /// The name of the multiplex program.
    program_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .multiplex_program_settings = "MultiplexProgramSettings",
        .packet_identifiers_map = "PacketIdentifiersMap",
        .pipeline_details = "PipelineDetails",
        .program_name = "ProgramName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteMultiplexProgramInput, options: CallOptions) !DeleteMultiplexProgramOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteMultiplexProgramInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/multiplexes/");
    try path_buf.appendSlice(allocator, input.multiplex_id);
    try path_buf.appendSlice(allocator, "/programs/");
    try path_buf.appendSlice(allocator, input.program_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteMultiplexProgramOutput {
    var result: DeleteMultiplexProgramOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteMultiplexProgramOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
