const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClassificationExportConfiguration = @import("classification_export_configuration.zig").ClassificationExportConfiguration;

pub const PutClassificationExportConfigurationInput = struct {
    /// The location to store data classification results in, and the encryption
    /// settings to use when storing results in that location.
    configuration: ClassificationExportConfiguration,

    pub const json_field_names = .{
        .configuration = "configuration",
    };
};

pub const PutClassificationExportConfigurationOutput = struct {
    /// The location where the data classification results are stored, and the
    /// encryption settings that are used when storing results in that location.
    configuration: ?ClassificationExportConfiguration = null,

    pub const json_field_names = .{
        .configuration = "configuration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutClassificationExportConfigurationInput, options: CallOptions) !PutClassificationExportConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutClassificationExportConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/classification-export-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutClassificationExportConfigurationOutput {
    var result: PutClassificationExportConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutClassificationExportConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
