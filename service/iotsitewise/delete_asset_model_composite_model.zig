const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetModelVersionType = @import("asset_model_version_type.zig").AssetModelVersionType;
const AssetModelStatus = @import("asset_model_status.zig").AssetModelStatus;

pub const DeleteAssetModelCompositeModelInput = struct {
    /// The ID of a composite model on this asset model.
    asset_model_composite_model_id: []const u8,

    /// The ID of the asset model, in UUID format.
    asset_model_id: []const u8,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The expected current entity tag (ETag) for the asset model’s latest or
    /// active version (specified using `matchForVersionType`).
    /// The delete request is rejected if the tag does not match the latest or
    /// active version's current entity tag.
    /// See [Optimistic locking for asset model
    /// writes](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/opt-locking-for-model.html)
    /// in the *IoT SiteWise User Guide*.
    if_match: ?[]const u8 = null,

    /// Accepts ***** to reject the delete request if an active version
    /// (specified using `matchForVersionType` as `ACTIVE`) already exists for the
    /// asset model.
    if_none_match: ?[]const u8 = null,

    /// Specifies the asset model version type (`LATEST` or `ACTIVE`) used in
    /// conjunction with `If-Match` or `If-None-Match` headers to determine the
    /// target ETag for the delete operation.
    match_for_version_type: ?AssetModelVersionType = null,

    pub const json_field_names = .{
        .asset_model_composite_model_id = "assetModelCompositeModelId",
        .asset_model_id = "assetModelId",
        .client_token = "clientToken",
        .if_match = "ifMatch",
        .if_none_match = "ifNoneMatch",
        .match_for_version_type = "matchForVersionType",
    };
};

pub const DeleteAssetModelCompositeModelOutput = struct {
    asset_model_status: ?AssetModelStatus = null,

    pub const json_field_names = .{
        .asset_model_status = "assetModelStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAssetModelCompositeModelInput, options: CallOptions) !DeleteAssetModelCompositeModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAssetModelCompositeModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/asset-models/");
    try path_buf.appendSlice(allocator, input.asset_model_id);
    try path_buf.appendSlice(allocator, "/composite-models/");
    try path_buf.appendSlice(allocator, input.asset_model_composite_model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }
    if (input.if_none_match) |v| {
        try request.headers.put(allocator, "If-None-Match", v);
    }
    if (input.match_for_version_type) |v| {
        try request.headers.put(allocator, "Match-For-Version-Type", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAssetModelCompositeModelOutput {
    var result: DeleteAssetModelCompositeModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteAssetModelCompositeModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
