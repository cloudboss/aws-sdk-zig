const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NumberValidateRequest = @import("number_validate_request.zig").NumberValidateRequest;
const NumberValidateResponse = @import("number_validate_response.zig").NumberValidateResponse;

pub const PhoneNumberValidateInput = struct {
    number_validate_request: NumberValidateRequest,

    pub const json_field_names = .{
        .number_validate_request = "NumberValidateRequest",
    };
};

pub const PhoneNumberValidateOutput = struct {
    number_validate_response: ?NumberValidateResponse = null,

    pub const json_field_names = .{
        .number_validate_response = "NumberValidateResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PhoneNumberValidateInput, options: CallOptions) !PhoneNumberValidateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mobiletargeting", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PhoneNumberValidateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/phone/number/validate";

    const body = try aws.json.jsonStringify(input.number_validate_request, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PhoneNumberValidateOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PhoneNumberValidateOutput = .{};

    return result;
}
