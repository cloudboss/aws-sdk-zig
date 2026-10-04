const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainStatus = @import("domain_status.zig").DomainStatus;
const DryRunProgressStatus = @import("dry_run_progress_status.zig").DryRunProgressStatus;
const DryRunResults = @import("dry_run_results.zig").DryRunResults;

pub const DescribeDryRunProgressInput = struct {
    /// The name of the domain.
    domain_name: []const u8,

    /// The unique identifier of the dry run.
    dry_run_id: ?[]const u8 = null,

    /// Whether to include the configuration of the dry run in the response. The
    /// configuration
    /// specifies the updates that you're planning to make on the domain.
    load_dry_run_config: ?bool = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .dry_run_id = "DryRunId",
        .load_dry_run_config = "LoadDryRunConfig",
    };
};

pub const DescribeDryRunProgressOutput = struct {
    /// Details about the changes you're planning to make on the domain.
    dry_run_config: ?DomainStatus = null,

    /// The current status of the dry run, including any validation errors.
    dry_run_progress_status: ?DryRunProgressStatus = null,

    /// The results of the dry run.
    dry_run_results: ?DryRunResults = null,

    pub const json_field_names = .{
        .dry_run_config = "DryRunConfig",
        .dry_run_progress_status = "DryRunProgressStatus",
        .dry_run_results = "DryRunResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDryRunProgressInput, options: CallOptions) !DescribeDryRunProgressOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDryRunProgressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/dryRun");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.dry_run_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "dryRunId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.load_dry_run_config) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "loadDryRunConfig=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDryRunProgressOutput {
    var result: DescribeDryRunProgressOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDryRunProgressOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
