const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DatabaseResponse = @import("database_response.zig").DatabaseResponse;

pub const DescribeFleetAdvisorDatabasesInput = struct {
    /// If you specify any of the following filters, the output includes information
    /// for only
    /// those databases that meet the filter criteria:
    ///
    /// * `database-id` – The ID of the database.
    ///
    /// * `database-name` – The name of the database.
    ///
    /// * `database-engine` – The name of the database engine.
    ///
    /// * `server-ip-address` – The IP address of the database
    /// server.
    ///
    /// * `database-ip-address` – The IP address of the
    /// database.
    ///
    /// * `collector-name` – The name of the associated Fleet Advisor collector.
    ///
    /// An example is: `describe-fleet-advisor-databases --filter
    /// Name="database-id",Values="45"`
    filters: ?[]const Filter = null,

    /// Sets the maximum number of records returned in the response.
    max_records: ?i32 = null,

    /// If `NextToken` is returned by a previous response, there are more results
    /// available. The value of `NextToken` is a unique pagination token for each
    /// page. Make the call again using the returned token to retrieve the next
    /// page. Keep all
    /// other arguments unchanged.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_records = "MaxRecords",
        .next_token = "NextToken",
    };
};

pub const DescribeFleetAdvisorDatabasesOutput = struct {
    /// Provides descriptions of the Fleet Advisor collector databases, including
    /// the database's collector, ID,
    /// and name.
    databases: ?[]const DatabaseResponse = null,

    /// If `NextToken` is returned, there are more results available. The value of
    /// `NextToken` is a unique pagination token for each page. Make the call
    /// again using the returned token to retrieve the next page. Keep all other
    /// arguments
    /// unchanged.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .databases = "Databases",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFleetAdvisorDatabasesInput, options: CallOptions) !DescribeFleetAdvisorDatabasesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFleetAdvisorDatabasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeFleetAdvisorDatabases");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFleetAdvisorDatabasesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFleetAdvisorDatabasesOutput, body, allocator);
}
