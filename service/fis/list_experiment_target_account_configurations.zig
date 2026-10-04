const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExperimentTargetAccountConfigurationSummary = @import("experiment_target_account_configuration_summary.zig").ExperimentTargetAccountConfigurationSummary;

pub const ListExperimentTargetAccountConfigurationsInput = struct {
    /// The ID of the experiment.
    experiment_id: []const u8,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .experiment_id = "experimentId",
        .next_token = "nextToken",
    };
};

pub const ListExperimentTargetAccountConfigurationsOutput = struct {
    /// The token to use to retrieve the next page of results.
    /// This value is null when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The target account configurations.
    target_account_configurations: ?[]const ExperimentTargetAccountConfigurationSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .target_account_configurations = "targetAccountConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExperimentTargetAccountConfigurationsInput, options: CallOptions) !ListExperimentTargetAccountConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExperimentTargetAccountConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fis", "fis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/experiments/");
    try path_buf.appendSlice(allocator, input.experiment_id);
    try path_buf.appendSlice(allocator, "/targetAccountConfigurations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExperimentTargetAccountConfigurationsOutput {
    const result: ListExperimentTargetAccountConfigurationsOutput = try aws.json.parseJsonObject(
        ListExperimentTargetAccountConfigurationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
