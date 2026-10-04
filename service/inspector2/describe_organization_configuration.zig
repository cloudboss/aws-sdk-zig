const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoEnable = @import("auto_enable.zig").AutoEnable;

pub const DescribeOrganizationConfigurationInput = struct {
};

pub const DescribeOrganizationConfigurationOutput = struct {
    /// The scan types are automatically enabled for new members of your
    /// organization.
    auto_enable: ?AutoEnable = null,

    /// Represents whether your organization has reached the maximum Amazon Web
    /// Services account limit for
    /// Amazon Inspector.
    max_account_limit_reached: ?bool = null,

    pub const json_field_names = .{
        .auto_enable = "autoEnable",
        .max_account_limit_reached = "maxAccountLimitReached",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOrganizationConfigurationInput, options: CallOptions) !DescribeOrganizationConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOrganizationConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/organizationconfiguration/describe";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOrganizationConfigurationOutput {
    var result: DescribeOrganizationConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeOrganizationConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
