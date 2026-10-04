const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const SchemaResponse = @import("schema_response.zig").SchemaResponse;

pub const DescribeFleetAdvisorSchemasInput = struct {
    /// If you specify any of the following filters, the output includes information
    /// for only
    /// those schemas that meet the filter criteria:
    ///
    /// * `complexity` – The schema's complexity, for example
    /// `Simple`.
    ///
    /// * `database-id` – The ID of the schema's database.
    ///
    /// * `database-ip-address` – The IP address of the schema's
    /// database.
    ///
    /// * `database-name` – The name of the schema's database.
    ///
    /// * `database-engine` – The name of the schema database's
    /// engine.
    ///
    /// * `original-schema-name` – The name of the schema's database's
    /// main schema.
    ///
    /// * `schema-id` – The ID of the schema, for example
    /// `15`.
    ///
    /// * `schema-name` – The name of the schema.
    ///
    /// * `server-ip-address` – The IP address of the schema
    /// database's server.
    ///
    /// An example is: `describe-fleet-advisor-schemas --filter
    /// Name="schema-id",Values="50"`
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

pub const DescribeFleetAdvisorSchemasOutput = struct {
    /// A collection of `SchemaResponse` objects.
    fleet_advisor_schemas: ?[]const SchemaResponse = null,

    /// If `NextToken` is returned, there are more results available. The value of
    /// `NextToken` is a unique pagination token for each page. Make the call
    /// again using the returned token to retrieve the next page. Keep all other
    /// arguments
    /// unchanged.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .fleet_advisor_schemas = "FleetAdvisorSchemas",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFleetAdvisorSchemasInput, options: CallOptions) !DescribeFleetAdvisorSchemasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFleetAdvisorSchemasInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeFleetAdvisorSchemas");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFleetAdvisorSchemasOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFleetAdvisorSchemasOutput, body, allocator);
}
