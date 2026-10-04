const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetStatus = @import("asset_status.zig").AssetStatus;

pub const UpdateAssetInput = struct {
    /// A description for the asset.
    asset_description: ?[]const u8 = null,

    /// An external ID to assign to the asset. The asset must not already have an
    /// external ID.
    /// The external ID must be unique within your Amazon Web Services account. For
    /// more information, see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    asset_external_id: ?[]const u8 = null,

    /// The ID of the asset to update. This can be either the actual ID in UUID
    /// format, or else `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_id: []const u8,

    /// A friendly name for the asset.
    asset_name: []const u8,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_description = "assetDescription",
        .asset_external_id = "assetExternalId",
        .asset_id = "assetId",
        .asset_name = "assetName",
        .client_token = "clientToken",
    };
};

pub const UpdateAssetOutput = struct {
    /// The status of the asset, which contains a state (`UPDATING` after
    /// successfully
    /// calling this operation) and any error message.
    asset_status: ?AssetStatus = null,

    pub const json_field_names = .{
        .asset_status = "assetStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssetInput, options: CallOptions) !UpdateAssetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.asset_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.asset_external_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetExternalId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"assetName\":");
    try aws.json.writeValue(@TypeOf(input.asset_name), input.asset_name, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssetOutput {
    var result: UpdateAssetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAssetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
