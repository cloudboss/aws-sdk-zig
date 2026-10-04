const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RegisterThingInput = struct {
    /// The parameters for provisioning a thing. See [Provisioning
    /// Templates](https://docs.aws.amazon.com/iot/latest/developerguide/provision-template.html) for more information.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The provisioning template. See [Provisioning Devices That Have Device
    /// Certificates](https://docs.aws.amazon.com/iot/latest/developerguide/provision-w-cert.html) for more information.
    template_body: []const u8,

    pub const json_field_names = .{
        .parameters = "parameters",
        .template_body = "templateBody",
    };
};

pub const RegisterThingOutput = struct {
    /// The certificate data, in PEM format.
    certificate_pem: ?[]const u8 = null,

    /// ARNs for the generated resources.
    resource_arns: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .certificate_pem = "certificatePem",
        .resource_arns = "resourceArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterThingInput, options: CallOptions) !RegisterThingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterThingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/things";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateBody\":");
    try aws.json.writeValue(@TypeOf(input.template_body), input.template_body, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterThingOutput {
    var result: RegisterThingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterThingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
