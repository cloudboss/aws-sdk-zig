const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RemediationType = @import("remediation_type.zig").RemediationType;

pub const UpdateLandingZoneInput = struct {
    /// The unique identifier of the landing zone.
    landing_zone_identifier: []const u8,

    /// The manifest file (JSON) is a text file that describes your Amazon Web
    /// Services resources. For an example, review [Launch your landing
    /// zone](https://docs.aws.amazon.com/controltower/latest/userguide/lz-api-launch). The example manifest file contains each of the available parameters. The schema for the landing zone's JSON manifest file is not published, by design.
    manifest: ?[]const u8 = null,

    /// Specifies the types of remediation actions to apply when updating the
    /// landing zone configuration.
    remediation_types: ?[]const RemediationType = null,

    /// The landing zone version, for example, 3.2.
    version: []const u8,

    pub const json_field_names = .{
        .landing_zone_identifier = "landingZoneIdentifier",
        .manifest = "manifest",
        .remediation_types = "remediationTypes",
        .version = "version",
    };
};

pub const UpdateLandingZoneOutput = struct {
    /// A unique identifier assigned to a `UpdateLandingZone` operation. You can use
    /// this identifier as an input of `GetLandingZoneOperation` to check the
    /// operation's status.
    operation_identifier: []const u8,

    pub const json_field_names = .{
        .operation_identifier = "operationIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLandingZoneInput, options: CallOptions) !UpdateLandingZoneOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLandingZoneInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controltower", "ControlTower", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-landingzone";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"landingZoneIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.landing_zone_identifier), input.landing_zone_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.manifest) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"manifest\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remediation_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"remediationTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"version\":");
    try aws.json.writeValue(@TypeOf(input.version), input.version, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLandingZoneOutput {
    var result: UpdateLandingZoneOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateLandingZoneOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
