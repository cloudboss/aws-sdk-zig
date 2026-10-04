const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HierarchyMapping = @import("hierarchy_mapping.zig").HierarchyMapping;
const PropertyMapping = @import("property_mapping.zig").PropertyMapping;

pub const DescribeAssetModelInterfaceRelationshipInput = struct {
    /// The ID of the asset model. This can be either the actual ID in UUID format,
    /// or else
    /// externalId: followed by the external ID.
    asset_model_id: []const u8,

    /// The ID of the interface asset model. This can be either the actual ID in
    /// UUID format, or
    /// else externalId: followed by the external ID.
    interface_asset_model_id: []const u8,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
        .interface_asset_model_id = "interfaceAssetModelId",
    };
};

pub const DescribeAssetModelInterfaceRelationshipOutput = struct {
    /// The ID of the asset model.
    asset_model_id: []const u8,

    /// A list of hierarchy mappings between the interface asset model and the asset
    /// model where
    /// the interface is applied.
    hierarchy_mappings: ?[]const HierarchyMapping = null,

    /// The ID of the interface asset model.
    interface_asset_model_id: []const u8,

    /// A list of property mappings between the interface asset model and the asset
    /// model where
    /// the interface is applied.
    property_mappings: ?[]const PropertyMapping = null,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
        .hierarchy_mappings = "hierarchyMappings",
        .interface_asset_model_id = "interfaceAssetModelId",
        .property_mappings = "propertyMappings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssetModelInterfaceRelationshipInput, options: CallOptions) !DescribeAssetModelInterfaceRelationshipOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssetModelInterfaceRelationshipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/asset-models/");
    try path_buf.appendSlice(allocator, input.asset_model_id);
    try path_buf.appendSlice(allocator, "/interface/");
    try path_buf.appendSlice(allocator, input.interface_asset_model_id);
    try path_buf.appendSlice(allocator, "/asset-model-interface-relationship");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssetModelInterfaceRelationshipOutput {
    var result: DescribeAssetModelInterfaceRelationshipOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAssetModelInterfaceRelationshipOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
