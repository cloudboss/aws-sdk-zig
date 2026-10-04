const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatastoreFilter = @import("datastore_filter.zig").DatastoreFilter;
const DatastoreProperties = @import("datastore_properties.zig").DatastoreProperties;

pub const ListFHIRDatastoresInput = struct {
    /// List all filters associated with a FHIR data store request.
    filter: ?DatastoreFilter = null,

    /// The maximum number of data stores returned on a page.
    max_results: ?i32 = null,

    /// The token used to retrieve the next page of data stores when results are
    /// paginated.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListFHIRDatastoresOutput = struct {
    /// The properties associated with all listed data stores.
    datastore_properties_list: ?[]const DatastoreProperties = null,

    /// The pagination token used to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .datastore_properties_list = "DatastorePropertiesList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFHIRDatastoresInput, options: CallOptions) !ListFHIRDatastoresOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "healthlake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFHIRDatastoresInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("healthlake", "HealthLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.ListFHIRDatastores");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFHIRDatastoresOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListFHIRDatastoresOutput, body, allocator);
}
