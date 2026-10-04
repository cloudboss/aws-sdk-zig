const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceItemStatus = @import("resource_item_status.zig").ResourceItemStatus;
const ResourceType = @import("resource_type.zig").ResourceType;
const ApplicationTagResult = @import("application_tag_result.zig").ApplicationTagResult;
const AssociationOption = @import("association_option.zig").AssociationOption;
const Resource = @import("resource.zig").Resource;

pub const GetAssociatedResourceInput = struct {
    /// The name, ID, or ARN
    /// of the application.
    application: []const u8,

    /// The maximum number of results to return. If the parameter is omitted, it
    /// defaults to 25. The value is optional.
    max_results: ?i32 = null,

    /// A unique pagination token for each page of results.
    /// Make the call again with the returned token to retrieve the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The name or ID of the resource associated with the application.
    resource: []const u8,

    /// States whether an application tag is applied, not applied, in the process of
    /// being applied, or skipped.
    resource_tag_status: ?[]const ResourceItemStatus = null,

    /// The type of resource associated with the application.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .application = "application",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource = "resource",
        .resource_tag_status = "resourceTagStatus",
        .resource_type = "resourceType",
    };
};

pub const GetAssociatedResourceOutput = struct {
    /// The result of the application that's tag applied to a resource.
    application_tag_result: ?ApplicationTagResult = null,

    /// Determines whether an application tag is applied or skipped.
    options: ?[]const AssociationOption = null,

    /// The resource associated with the application.
    resource: ?Resource = null,

    pub const json_field_names = .{
        .application_tag_result = "applicationTagResult",
        .options = "options",
        .resource = "resource",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssociatedResourceInput, options: CallOptions) !GetAssociatedResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssociatedResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog-appregistry", "Service Catalog AppRegistry", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application);
    try path_buf.appendSlice(allocator, "/resources/");
    try path_buf.appendSlice(allocator, input.resource_type);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.resource);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    if (input.resource_tag_status) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "resourceTagStatus=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssociatedResourceOutput {
    var result: GetAssociatedResourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAssociatedResourceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
