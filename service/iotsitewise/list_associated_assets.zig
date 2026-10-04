const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TraversalDirection = @import("traversal_direction.zig").TraversalDirection;
const AssociatedAssetsSummary = @import("associated_assets_summary.zig").AssociatedAssetsSummary;

pub const ListAssociatedAssetsInput = struct {
    /// The ID of the asset to query. This can be either the actual ID in UUID
    /// format, or else `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_id: []const u8,

    /// (Optional) If you don't provide a `hierarchyId`, all the immediate assets in
    /// the `traversalDirection` will be returned.
    ///
    /// The ID of the hierarchy by which child assets are associated to the asset.
    /// (This can be either the actual ID in UUID format, or else `externalId:`
    /// followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.)
    ///
    /// For more information, see [Asset
    /// hierarchies](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-hierarchies.html) in the *IoT SiteWise User Guide*.
    hierarchy_id: ?[]const u8 = null,

    /// The maximum number of results to return for each paginated request.
    ///
    /// Default: 50
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// The direction to list associated assets. Choose one of the following
    /// options:
    ///
    /// * `CHILD` – The list includes all child assets associated to the
    /// asset.
    ///
    /// * `PARENT` – The list includes the asset's parent asset.
    ///
    /// Default: `CHILD`
    traversal_direction: ?TraversalDirection = null,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .hierarchy_id = "hierarchyId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .traversal_direction = "traversalDirection",
    };
};

pub const ListAssociatedAssetsOutput = struct {
    /// A list that summarizes the associated assets.
    asset_summaries: ?[]const AssociatedAssetsSummary = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_summaries = "assetSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssociatedAssetsInput, options: CallOptions) !ListAssociatedAssetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssociatedAssetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_id);
    try path_buf.appendSlice(allocator, "/hierarchies");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.hierarchy_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "hierarchyId=");
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
    if (input.traversal_direction) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "traversalDirection=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAssociatedAssetsOutput {
    var result: ListAssociatedAssetsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAssociatedAssetsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
