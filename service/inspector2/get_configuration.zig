const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Ec2ConfigurationState = @import("ec_2_configuration_state.zig").Ec2ConfigurationState;
const EcrConfigurationState = @import("ecr_configuration_state.zig").EcrConfigurationState;

pub const GetConfigurationInput = struct {
};

pub const GetConfigurationOutput = struct {
    /// Specifies how the Amazon EC2 automated scan mode is currently configured for
    /// your
    /// environment.
    ec_2_configuration: ?Ec2ConfigurationState = null,

    /// Specifies how the ECR automated re-scan duration is currently configured for
    /// your
    /// environment.
    ecr_configuration: ?EcrConfigurationState = null,

    pub const json_field_names = .{
        .ec_2_configuration = "ec2Configuration",
        .ecr_configuration = "ecrConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfigurationInput, options: CallOptions) !GetConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configuration/get";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigurationOutput {
    var result: GetConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
