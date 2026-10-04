const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CatalogItemClass = @import("catalog_item_class.zig").CatalogItemClass;
const SupportedStorageEnum = @import("supported_storage_enum.zig").SupportedStorageEnum;
const CatalogItem = @import("catalog_item.zig").CatalogItem;

pub const ListCatalogItemsInput = struct {
    /// Filters the results by EC2 family (for example, M5).
    ec2_family_filter: ?[]const []const u8 = null,

    /// Filters the results by item class.
    item_class_filter: ?[]const CatalogItemClass = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// Filters the results by storage option.
    supported_storage_filter: ?[]const SupportedStorageEnum = null,

    pub const json_field_names = .{
        .ec2_family_filter = "EC2FamilyFilter",
        .item_class_filter = "ItemClassFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .supported_storage_filter = "SupportedStorageFilter",
    };
};

pub const ListCatalogItemsOutput = struct {
    /// Information about the catalog items.
    catalog_items: ?[]const CatalogItem = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_items = "CatalogItems",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCatalogItemsInput, options: CallOptions) !ListCatalogItemsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCatalogItemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/catalog/items";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.ec2_family_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "EC2FamilyFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.item_class_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "ItemClassFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.supported_storage_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "SupportedStorageFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCatalogItemsOutput {
    var result: ListCatalogItemsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListCatalogItemsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
