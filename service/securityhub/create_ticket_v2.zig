const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TicketCreationMode = @import("ticket_creation_mode.zig").TicketCreationMode;

pub const CreateTicketV2Input = struct {
    /// The client idempotency token.
    client_token: ?[]const u8 = null,

    /// The UUID of the connectorV2 to identify connectorV2 resource.
    connector_id: []const u8,

    /// The the unique ID for the finding.
    finding_metadata_uid: []const u8,

    /// The mode for ticket creation. When set to DRYRUN, the ticket is created
    /// using a Security Hub owned template test finding to verify the integration
    /// is working correctly.
    mode: ?TicketCreationMode = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .connector_id = "ConnectorId",
        .finding_metadata_uid = "FindingMetadataUid",
        .mode = "Mode",
    };
};

pub const CreateTicketV2Output = struct {
    /// The ID for the ticketv2.
    ticket_id: []const u8,

    /// The url to the created ticket.
    ticket_src_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .ticket_id = "TicketId",
        .ticket_src_url = "TicketSrcUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTicketV2Input, options: CallOptions) !CreateTicketV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTicketV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ticketsv2";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConnectorId\":");
    try aws.json.writeValue(@TypeOf(input.connector_id), input.connector_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FindingMetadataUid\":");
    try aws.json.writeValue(@TypeOf(input.finding_metadata_uid), input.finding_metadata_uid, allocator, &body_buf);
    has_prev = true;
    if (input.mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Mode\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTicketV2Output {
    const result: CreateTicketV2Output = try aws.json.parseJsonObject(
        CreateTicketV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
