const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const IngestionDestination = @import("ingestion_destination.zig").IngestionDestination;

pub const UpdateIngestionDestinationInput = struct {
    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// app bundle
    /// to use for the request.
    app_bundle_identifier: []const u8,

    /// Contains information about the destination of ingested data.
    destination_configuration: DestinationConfiguration,

    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// ingestion
    /// destination to use for the request.
    ingestion_destination_identifier: []const u8,

    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// ingestion to
    /// use for the request.
    ingestion_identifier: []const u8,

    pub const json_field_names = .{
        .app_bundle_identifier = "appBundleIdentifier",
        .destination_configuration = "destinationConfiguration",
        .ingestion_destination_identifier = "ingestionDestinationIdentifier",
        .ingestion_identifier = "ingestionIdentifier",
    };
};

pub const UpdateIngestionDestinationOutput = struct {
    /// Contains information about an ingestion destination.
    ingestion_destination: ?IngestionDestination = null,

    pub const json_field_names = .{
        .ingestion_destination = "ingestionDestination",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIngestionDestinationInput, options: CallOptions) !UpdateIngestionDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIngestionDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appfabric", "AppFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/appbundles/");
    try path_buf.appendSlice(allocator, input.app_bundle_identifier);
    try path_buf.appendSlice(allocator, "/ingestions/");
    try path_buf.appendSlice(allocator, input.ingestion_identifier);
    try path_buf.appendSlice(allocator, "/ingestiondestinations/");
    try path_buf.appendSlice(allocator, input.ingestion_destination_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.destination_configuration), input.destination_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIngestionDestinationOutput {
    const result: UpdateIngestionDestinationOutput = try aws.json.parseJsonObject(
        UpdateIngestionDestinationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
