const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetModelStatus = @import("asset_model_status.zig").AssetModelStatus;

pub const DeleteAssetModelInterfaceRelationshipInput = struct {
    /// The ID of the asset model. This can be either the actual ID in UUID format,
    /// or else
    /// externalId: followed by the external ID.
    asset_model_id: []const u8,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the
    /// request. Don't reuse this client token if a new idempotent request is
    /// required.
    client_token: ?[]const u8 = null,

    /// The ID of the interface asset model. This can be either the actual ID in
    /// UUID format, or
    /// else externalId: followed by the external ID.
    interface_asset_model_id: []const u8,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
        .client_token = "clientToken",
        .interface_asset_model_id = "interfaceAssetModelId",
    };
};

pub const DeleteAssetModelInterfaceRelationshipOutput = struct {
    /// The ARN of the asset model, which has the following format.
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:asset-model/${AssetModelId}`
    asset_model_arn: []const u8,

    /// The ID of the asset model.
    asset_model_id: []const u8,

    asset_model_status: ?AssetModelStatus = null,

    /// The ID of the interface asset model.
    interface_asset_model_id: []const u8,

    pub const json_field_names = .{
        .asset_model_arn = "assetModelArn",
        .asset_model_id = "assetModelId",
        .asset_model_status = "assetModelStatus",
        .interface_asset_model_id = "interfaceAssetModelId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAssetModelInterfaceRelationshipInput, options: CallOptions) !DeleteAssetModelInterfaceRelationshipOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAssetModelInterfaceRelationshipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/asset-models/");
    try path_buf.appendSlice(allocator, input.asset_model_id);
    try path_buf.appendSlice(allocator, "/interface/");
    try path_buf.appendSlice(allocator, input.interface_asset_model_id);
    try path_buf.appendSlice(allocator, "/asset-model-interface-relationship");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAssetModelInterfaceRelationshipOutput {
    var result: DeleteAssetModelInterfaceRelationshipOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteAssetModelInterfaceRelationshipOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
