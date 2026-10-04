const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Ec2ConfigurationState = @import("ec_2_configuration_state.zig").Ec2ConfigurationState;
const EcrConfigurationState = @import("ecr_configuration_state.zig").EcrConfigurationState;

pub const GetConfigurationInput = struct {
    /// The 12-digit Amazon Web Services account ID of the member account whose scan
    /// configuration you want
    /// to retrieve. When specified, you must be the delegated administrator for
    /// this
    /// member account. If not specified, the operation returns your own
    /// configuration.
    account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
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
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configuration/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigurationOutput {
    const result: GetConfigurationOutput = try aws.json.parseJsonObject(
        GetConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
