const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobType = @import("job_type.zig").JobType;

pub const PopulateIdMappingTableInput = struct {
    /// The unique identifier of the ID mapping table that you want to populate.
    id_mapping_table_identifier: []const u8,

    /// The job type of the rule-based ID mapping job. Valid values include:
    ///
    /// `INCREMENTAL`: Processes only new or changed data since the last job run.
    /// This is the default job type if the ID mapping workflow was created in
    /// Entity Resolution with `incrementalRunConfig` specified.
    ///
    /// `BATCH`: Processes all data from the input source, regardless of previous
    /// job runs. This is the default job type if the ID mapping workflow was
    /// created in Entity Resolution but `incrementalRunConfig` wasn't specified.
    ///
    /// `DELETE_ONLY`: Processes only deletion requests from `BatchDeleteUniqueId`,
    /// which is set in Entity Resolution.
    ///
    /// For more information about `incrementalRunConfig` and `BatchDeleteUniqueId`,
    /// see the [Entity Resolution API
    /// Reference](https://docs.aws.amazon.com/entityresolution/latest/apireference/Welcome.html).
    job_type: ?JobType = null,

    /// The unique identifier of the membership that contains the ID mapping table
    /// that you want to populate.
    membership_identifier: []const u8,

    pub const json_field_names = .{
        .id_mapping_table_identifier = "idMappingTableIdentifier",
        .job_type = "jobType",
        .membership_identifier = "membershipIdentifier",
    };
};

pub const PopulateIdMappingTableOutput = struct {
    /// The unique identifier of the mapping job that will populate the ID mapping
    /// table.
    id_mapping_job_id: []const u8,

    pub const json_field_names = .{
        .id_mapping_job_id = "idMappingJobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PopulateIdMappingTableInput, options: CallOptions) !PopulateIdMappingTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PopulateIdMappingTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/idmappingtables/");
    try path_buf.appendSlice(allocator, input.id_mapping_table_identifier);
    try path_buf.appendSlice(allocator, "/populate");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.job_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PopulateIdMappingTableOutput {
    const result: PopulateIdMappingTableOutput = try aws.json.parseJsonObject(
        PopulateIdMappingTableOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
