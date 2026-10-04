const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateResourceExplorerSetupInput = struct {
    /// A list of Amazon Web Services Regions that should be configured as
    /// aggregator Regions. Aggregator Regions receive replicated index information
    /// from all other Regions where there is a user-owned index.
    aggregator_regions: ?[]const []const u8 = null,

    /// A list of Amazon Web Services Regions where Resource Explorer should be
    /// configured. Each Region in the list will have a user-owned index created.
    region_list: []const []const u8,

    /// The name for the view to be created as part of the Resource Explorer setup.
    /// The view name must be unique within the Amazon Web Services account and
    /// Region.
    view_name: []const u8,

    pub const json_field_names = .{
        .aggregator_regions = "AggregatorRegions",
        .region_list = "RegionList",
        .view_name = "ViewName",
    };
};

pub const CreateResourceExplorerSetupOutput = struct {
    /// The unique identifier for the setup task. Use this ID with
    /// `GetResourceExplorerSetup` to monitor the progress of the configuration
    /// operation.
    task_id: []const u8,

    pub const json_field_names = .{
        .task_id = "TaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceExplorerSetupInput, options: CallOptions) !CreateResourceExplorerSetupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-explorer-2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourceExplorerSetupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-explorer-2", "Resource Explorer 2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateResourceExplorerSetup";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aggregator_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AggregatorRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RegionList\":");
    try aws.json.writeValue(@TypeOf(input.region_list), input.region_list, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ViewName\":");
    try aws.json.writeValue(@TypeOf(input.view_name), input.view_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourceExplorerSetupOutput {
    const result: CreateResourceExplorerSetupOutput = try aws.json.parseJsonObject(
        CreateResourceExplorerSetupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
