const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngestionJob = @import("ingestion_job.zig").IngestionJob;

pub const StopIngestionJobInput = struct {
    /// The unique identifier of the data source for the data ingestion job you want
    /// to stop.
    data_source_id: []const u8,

    /// The unique identifier of the data ingestion job you want to stop.
    ingestion_job_id: []const u8,

    /// The unique identifier of the knowledge base for the data ingestion job you
    /// want to stop.
    knowledge_base_id: []const u8,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .ingestion_job_id = "ingestionJobId",
        .knowledge_base_id = "knowledgeBaseId",
    };
};

pub const StopIngestionJobOutput = struct {
    /// Contains information about the stopped data ingestion job.
    ingestion_job: ?IngestionJob = null,

    pub const json_field_names = .{
        .ingestion_job = "ingestionJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopIngestionJobInput, options: CallOptions) !StopIngestionJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopIngestionJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/datasources/");
    try path_buf.appendSlice(allocator, input.data_source_id);
    try path_buf.appendSlice(allocator, "/ingestionjobs/");
    try path_buf.appendSlice(allocator, input.ingestion_job_id);
    try path_buf.appendSlice(allocator, "/stop");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopIngestionJobOutput {
    var result: StopIngestionJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StopIngestionJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
