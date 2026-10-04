const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const MetadataTransferJobStatus = @import("metadata_transfer_job_status.zig").MetadataTransferJobStatus;

pub const CreateMetadataTransferJobInput = struct {
    /// The metadata transfer job description.
    description: ?[]const u8 = null,

    /// The metadata transfer job destination.
    destination: DestinationConfiguration,

    /// The metadata transfer job Id.
    metadata_transfer_job_id: ?[]const u8 = null,

    /// The metadata transfer job sources.
    sources: []const SourceConfiguration,

    pub const json_field_names = .{
        .description = "description",
        .destination = "destination",
        .metadata_transfer_job_id = "metadataTransferJobId",
        .sources = "sources",
    };
};

pub const CreateMetadataTransferJobOutput = struct {
    /// The metadata transfer job ARN.
    arn: []const u8,

    /// The The metadata transfer job creation DateTime property.
    creation_date_time: i64,

    /// The metadata transfer job Id.
    metadata_transfer_job_id: []const u8,

    /// The metadata transfer job response status.
    status: ?MetadataTransferJobStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .metadata_transfer_job_id = "metadataTransferJobId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMetadataTransferJobInput, options: CallOptions) !CreateMetadataTransferJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsiottwinmaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMetadataTransferJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/metadata-transfer-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, allocator, &body_buf);
    has_prev = true;
    if (input.metadata_transfer_job_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadataTransferJobId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sources\":");
    try aws.json.writeValue(@TypeOf(input.sources), input.sources, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMetadataTransferJobOutput {
    var result: CreateMetadataTransferJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMetadataTransferJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
