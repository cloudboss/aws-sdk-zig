const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PropertyMappingConfiguration = @import("property_mapping_configuration.zig").PropertyMappingConfiguration;
const AssetModelStatus = @import("asset_model_status.zig").AssetModelStatus;

pub const PutAssetModelInterfaceRelationshipInput = struct {
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

    /// The configuration for mapping properties from the interface asset model to
    /// the asset model
    /// where the interface is applied. This configuration controls how properties
    /// are matched and
    /// created during the interface application process.
    property_mapping_configuration: PropertyMappingConfiguration,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
        .client_token = "clientToken",
        .interface_asset_model_id = "interfaceAssetModelId",
        .property_mapping_configuration = "propertyMappingConfiguration",
    };
};

pub const PutAssetModelInterfaceRelationshipOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAssetModelInterfaceRelationshipInput, options: CallOptions) !PutAssetModelInterfaceRelationshipOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAssetModelInterfaceRelationshipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/asset-models/");
    try path_buf.appendSlice(allocator, input.asset_model_id);
    try path_buf.appendSlice(allocator, "/interface/");
    try path_buf.appendSlice(allocator, input.interface_asset_model_id);
    try path_buf.appendSlice(allocator, "/asset-model-interface-relationship");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"propertyMappingConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.property_mapping_configuration), input.property_mapping_configuration, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAssetModelInterfaceRelationshipOutput {
    const result: PutAssetModelInterfaceRelationshipOutput = try aws.json.parseJsonObject(
        PutAssetModelInterfaceRelationshipOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
