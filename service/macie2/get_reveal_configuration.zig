const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RevealConfiguration = @import("reveal_configuration.zig").RevealConfiguration;
const RetrievalConfiguration = @import("retrieval_configuration.zig").RetrievalConfiguration;

pub const GetRevealConfigurationInput = struct {
};

pub const GetRevealConfigurationOutput = struct {
    /// The KMS key that's used to encrypt the sensitive data, and the status of the
    /// configuration for the Amazon Macie account.
    configuration: ?RevealConfiguration = null,

    /// The access method and settings that are used to retrieve the sensitive data.
    retrieval_configuration: ?RetrievalConfiguration = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .retrieval_configuration = "retrievalConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRevealConfigurationInput, options: CallOptions) !GetRevealConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRevealConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/reveal-configuration";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRevealConfigurationOutput {
    const result: GetRevealConfigurationOutput = try aws.json.parseJsonObject(
        GetRevealConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
