const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;
const ActivityTypeInfo = @import("activity_type_info.zig").ActivityTypeInfo;

pub const ListActivityTypesInput = struct {
    /// The name of the domain in which the activity types have been registered.
    domain: []const u8,

    /// The maximum number of results that are returned per call.
    /// Use `nextPageToken` to obtain further pages of results.
    maximum_page_size: ?i32 = null,

    /// If specified, only lists the activity types that have this name.
    name: ?[]const u8 = null,

    /// If `NextPageToken` is returned there are more results
    /// available. The value of `NextPageToken` is a unique pagination token for
    /// each page. Make the call again using
    /// the returned token to retrieve the next page. Keep all other arguments
    /// unchanged. Each pagination token expires
    /// after 24 hours. Using an expired pagination token will return a `400` error:
    /// "`Specified token has
    /// exceeded its maximum lifetime`".
    ///
    /// The configured `maximumPageSize` determines how many results can be returned
    /// in a single call.
    next_page_token: ?[]const u8 = null,

    /// Specifies the registration status of the activity types to list.
    registration_status: RegistrationStatus,

    /// When set to `true`, returns the results in reverse order. By default, the
    /// results are returned in ascending alphabetical order by `name` of the
    /// activity
    /// types.
    reverse_order: ?bool = null,

    pub const json_field_names = .{
        .domain = "domain",
        .maximum_page_size = "maximumPageSize",
        .name = "name",
        .next_page_token = "nextPageToken",
        .registration_status = "registrationStatus",
        .reverse_order = "reverseOrder",
    };
};

pub const ListActivityTypesOutput = struct {
    /// If a `NextPageToken` was returned by a previous call, there are more
    /// results available. To retrieve the next page of results, make the call again
    /// using the returned token in
    /// `nextPageToken`. Keep all other arguments unchanged.
    ///
    /// The configured `maximumPageSize` determines how many results can be returned
    /// in a single call.
    next_page_token: ?[]const u8 = null,

    /// List of activity type information.
    type_infos: ?[]const ActivityTypeInfo = null,

    pub const json_field_names = .{
        .next_page_token = "nextPageToken",
        .type_infos = "typeInfos",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListActivityTypesInput, options: CallOptions) !ListActivityTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListActivityTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.ListActivityTypes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListActivityTypesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListActivityTypesOutput, body, allocator);
}
