const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteLandingZoneInput = struct {
    /// The unique identifier of the landing zone.
    landing_zone_identifier: []const u8,

    pub const json_field_names = .{
        .landing_zone_identifier = "landingZoneIdentifier",
    };
};

pub const DeleteLandingZoneOutput = struct {
    /// >A unique identifier assigned to a `DeleteLandingZone` operation. You can
    /// use this identifier as an input parameter of `GetLandingZoneOperation` to
    /// check the operation's status.
    operation_identifier: []const u8,

    pub const json_field_names = .{
        .operation_identifier = "operationIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteLandingZoneInput, options: CallOptions) !DeleteLandingZoneOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "controltower", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteLandingZoneInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controltower", "ControlTower", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/delete-landingzone";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"landingZoneIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.landing_zone_identifier), input.landing_zone_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteLandingZoneOutput {
    const result: DeleteLandingZoneOutput = try aws.json.parseJsonObject(
        DeleteLandingZoneOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
