const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetFilterConfiguration = @import("asset_filter_configuration.zig").AssetFilterConfiguration;
const FilterStatus = @import("filter_status.zig").FilterStatus;

pub const UpdateAssetFilterInput = struct {
    /// The ID of the data asset.
    asset_identifier: []const u8,

    /// The configuration of the asset filter.
    configuration: ?AssetFilterConfiguration = null,

    /// The description of the asset filter.
    description: ?[]const u8 = null,

    /// The ID of the domain where you want to update an asset filter.
    domain_identifier: []const u8,

    /// The ID of the asset filter.
    identifier: []const u8,

    /// The name of the asset filter.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_identifier = "assetIdentifier",
        .configuration = "configuration",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .name = "name",
    };
};

pub const UpdateAssetFilterOutput = struct {
    /// The ID of the data asset.
    asset_id: []const u8,

    /// The configuration of the asset filter.
    configuration: ?AssetFilterConfiguration = null,

    /// The timestamp at which the asset filter was created.
    created_at: ?i64 = null,

    /// The description of the asset filter.
    description: ?[]const u8 = null,

    /// The ID of the domain where the asset filter was created.
    domain_id: []const u8,

    /// The column names of the asset filter.
    effective_column_names: ?[]const []const u8 = null,

    /// The row filter of the asset filter.
    effective_row_filter: ?[]const u8 = null,

    /// The error message that is displayed if the action is not completed
    /// successfully.
    error_message: ?[]const u8 = null,

    /// The ID of the asset filter.
    id: []const u8,

    /// The name of the asset filter.
    name: []const u8,

    /// The status of the asset filter.
    status: ?FilterStatus = null,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .configuration = "configuration",
        .created_at = "createdAt",
        .description = "description",
        .domain_id = "domainId",
        .effective_column_names = "effectiveColumnNames",
        .effective_row_filter = "effectiveRowFilter",
        .error_message = "errorMessage",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssetFilterInput, options: CallOptions) !UpdateAssetFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssetFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_identifier);
    try path_buf.appendSlice(allocator, "/filters/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssetFilterOutput {
    const result: UpdateAssetFilterOutput = try aws.json.parseJsonObject(
        UpdateAssetFilterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
