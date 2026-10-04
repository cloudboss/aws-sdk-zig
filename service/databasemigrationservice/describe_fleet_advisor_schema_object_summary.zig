const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const FleetAdvisorSchemaObjectResponse = @import("fleet_advisor_schema_object_response.zig").FleetAdvisorSchemaObjectResponse;

pub const DescribeFleetAdvisorSchemaObjectSummaryInput = struct {
    /// If you specify any of the following filters, the output includes information
    /// for only
    /// those schema objects that meet the filter criteria:
    ///
    /// * `schema-id` – The ID of the schema, for example
    /// `d4610ac5-e323-4ad9-bc50-eaf7249dfe9d`.
    ///
    /// Example: `describe-fleet-advisor-schema-object-summary --filter
    /// Name="schema-id",Values="50"`
    filters: ?[]const Filter = null,

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
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

pub const DescribeFleetAdvisorSchemaObjectSummaryOutput = struct {
    /// A collection of `FleetAdvisorSchemaObjectResponse` objects.
    fleet_advisor_schema_objects: ?[]const FleetAdvisorSchemaObjectResponse = null,

    /// If `NextToken` is returned, there are more results available. The value of
    /// `NextToken` is a unique pagination token for each page. Make the call
    /// again using the returned token to retrieve the next page. Keep all other
    /// arguments
    /// unchanged.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .fleet_advisor_schema_objects = "FleetAdvisorSchemaObjects",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFleetAdvisorSchemaObjectSummaryInput, options: CallOptions) !DescribeFleetAdvisorSchemaObjectSummaryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFleetAdvisorSchemaObjectSummaryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeFleetAdvisorSchemaObjectSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFleetAdvisorSchemaObjectSummaryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFleetAdvisorSchemaObjectSummaryOutput, body, allocator);
}
