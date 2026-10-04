const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const Tag = @import("tag.zig").Tag;
const IngestionDestination = @import("ingestion_destination.zig").IngestionDestination;

pub const CreateIngestionDestinationInput = struct {
    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// app bundle
    /// to use for the request.
    app_bundle_identifier: []const u8,

    /// Specifies a unique, case-sensitive identifier that you provide to ensure the
    /// idempotency
    /// of the request. This lets you safely retry the request without accidentally
    /// performing the
    /// same operation a second time. Passing the same value to a later call to an
    /// operation
    /// requires that you also pass the same value for all other parameters. We
    /// recommend that you
    /// use a [UUID type of
    /// value](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for
    /// you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with different
    /// parameters, the retry fails with an `IdempotentParameterMismatch` error.
    client_token: ?[]const u8 = null,

    /// Contains information about the destination of ingested data.
    destination_configuration: DestinationConfiguration,

    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// ingestion to
    /// use for the request.
    ingestion_identifier: []const u8,

    /// Contains information about how ingested data is processed.
    processing_configuration: ProcessingConfiguration,

    /// A map of the key-value pairs of the tag or tags to assign to the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .app_bundle_identifier = "appBundleIdentifier",
        .client_token = "clientToken",
        .destination_configuration = "destinationConfiguration",
        .ingestion_identifier = "ingestionIdentifier",
        .processing_configuration = "processingConfiguration",
        .tags = "tags",
    };
};

pub const CreateIngestionDestinationOutput = struct {
    /// Contains information about an ingestion destination.
    ingestion_destination: ?IngestionDestination = null,

    pub const json_field_names = .{
        .ingestion_destination = "ingestionDestination",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIngestionDestinationInput, options: CallOptions) !CreateIngestionDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIngestionDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appfabric", "AppFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/appbundles/");
    try path_buf.appendSlice(allocator, input.app_bundle_identifier);
    try path_buf.appendSlice(allocator, "/ingestions/");
    try path_buf.appendSlice(allocator, input.ingestion_identifier);
    try path_buf.appendSlice(allocator, "/ingestiondestinations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.destination_configuration), input.destination_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"processingConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.processing_configuration), input.processing_configuration, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIngestionDestinationOutput {
    var result: CreateIngestionDestinationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateIngestionDestinationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
