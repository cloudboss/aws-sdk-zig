const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InventoryFilter = @import("inventory_filter.zig").InventoryFilter;
const ResourceInventory = @import("resource_inventory.zig").ResourceInventory;

pub const ListResourceInventoryInput = struct {
    /// Filters to scope the results. The following filters and logical operators
    /// are supported:
    ///
    /// * `account_id` - The ID of the Amazon Web Services account that owns the
    ///   resource.
    /// Logical operators are `EQUALS` | `NOT_EQUALS`.
    ///
    /// * `application_name` - The name of the application.
    /// Logical operators are `EQUALS` | `BEGINS_WITH`.
    ///
    /// * `license_included` - The type of license included.
    /// Logical operators are `EQUALS` | `NOT_EQUALS`.
    /// Possible values are `sql-server-enterprise` |
    /// `sql-server-standard` |
    /// `sql-server-web` |
    /// `windows-server-datacenter`.
    ///
    /// * `platform` - The platform of the resource.
    /// Logical operators are `EQUALS` | `BEGINS_WITH`.
    ///
    /// * `resource_id` - The ID of the resource.
    /// Logical operators are `EQUALS` | `NOT_EQUALS`.
    ///
    /// * `tag:` - The key/value combination of a tag assigned
    /// to the resource. Logical operators are `EQUALS` (single account) or
    /// `EQUALS` | `NOT_EQUALS` (cross account).
    filters: ?[]const InventoryFilter = null,

    /// Maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// Token for the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListResourceInventoryOutput = struct {
    /// Token for the next set of results.
    next_token: ?[]const u8 = null,

    /// Information about the resources.
    resource_inventory_list: ?[]const ResourceInventory = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_inventory_list = "ResourceInventoryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceInventoryInput, options: CallOptions) !ListResourceInventoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceInventoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager", "License Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.ListResourceInventory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceInventoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResourceInventoryOutput, body, allocator);
}
