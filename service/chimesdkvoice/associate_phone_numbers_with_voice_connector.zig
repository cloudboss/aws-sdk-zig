const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberError = @import("phone_number_error.zig").PhoneNumberError;

pub const AssociatePhoneNumbersWithVoiceConnectorInput = struct {
    /// List of phone numbers, in E.164 format.
    e164_phone_numbers: []const []const u8,

    /// If true, associates the provided phone numbers with the provided Amazon
    /// Chime SDK Voice Connector and removes any previously existing associations.
    /// If false, does not associate any phone numbers that have previously existing
    /// associations.
    force_associate: ?bool = null,

    /// The Voice Connector ID.
    voice_connector_id: []const u8,

    pub const json_field_names = .{
        .e164_phone_numbers = "E164PhoneNumbers",
        .force_associate = "ForceAssociate",
        .voice_connector_id = "VoiceConnectorId",
    };
};

pub const AssociatePhoneNumbersWithVoiceConnectorOutput = struct {
    /// If the action fails for one or more of the phone numbers in the request, a
    /// list of the phone numbers is returned, along with error codes and
    /// error messages.
    phone_number_errors: ?[]const PhoneNumberError = null,

    pub const json_field_names = .{
        .phone_number_errors = "PhoneNumberErrors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociatePhoneNumbersWithVoiceConnectorInput, options: CallOptions) !AssociatePhoneNumbersWithVoiceConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociatePhoneNumbersWithVoiceConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/voice-connectors/");
    try path_buf.appendSlice(allocator, input.voice_connector_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=associate-phone-numbers");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"E164PhoneNumbers\":");
    try aws.json.writeValue(@TypeOf(input.e164_phone_numbers), input.e164_phone_numbers, allocator, &body_buf);
    has_prev = true;
    if (input.force_associate) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ForceAssociate\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociatePhoneNumbersWithVoiceConnectorOutput {
    var result: AssociatePhoneNumbersWithVoiceConnectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociatePhoneNumbersWithVoiceConnectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
