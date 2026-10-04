const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetModelType = @import("asset_model_type.zig").AssetModelType;
const AssetModelSummary = @import("asset_model_summary.zig").AssetModelSummary;

pub const ListAssetModelsInput = struct {
    /// The type of asset model. If you don't provide an `assetModelTypes`, all
    /// types
    /// of asset models are returned.
    ///
    /// * **ASSET_MODEL** – An asset model that you can use
    /// to create assets. Can't be included as a component in another asset model.
    ///
    /// * **COMPONENT_MODEL** – A reusable component that
    /// you can include in the composite models of other asset models. You can't
    /// create
    /// assets directly from this type of asset model.
    ///
    /// * **INTERFACE** – An interface is a type of model
    /// that defines a standard structure that can be applied to different asset
    /// models.
    asset_model_types: ?[]const AssetModelType = null,

    /// The version alias that specifies the latest or active version of the asset
    /// model.
    /// The details are returned in the response. The default value is `LATEST`. See
    /// [
    /// Asset model
    /// versions](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/model-active-version.html) in the *IoT SiteWise User Guide*.
    asset_model_version: ?[]const u8 = null,

    /// The maximum number of results to return for each paginated request.
    ///
    /// Default: 50
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_model_types = "assetModelTypes",
        .asset_model_version = "assetModelVersion",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAssetModelsOutput = struct {
    /// A list that summarizes each asset model.
    asset_model_summaries: ?[]const AssetModelSummary = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_model_summaries = "assetModelSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssetModelsInput, options: CallOptions) !ListAssetModelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssetModelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/asset-models";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.asset_model_types) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "assetModelTypes=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.asset_model_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "assetModelVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAssetModelsOutput {
    var result: ListAssetModelsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAssetModelsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
