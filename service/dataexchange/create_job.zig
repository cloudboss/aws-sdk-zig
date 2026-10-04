const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetConfiguration = @import("asset_configuration.zig").AssetConfiguration;
const RequestDetails = @import("request_details.zig").RequestDetails;
const Type = @import("type.zig").Type;
const ResponseDetails = @import("response_details.zig").ResponseDetails;
const JobError = @import("job_error.zig").JobError;
const State = @import("state.zig").State;

pub const CreateJobInput = struct {
    /// The configuration for the asset, including tags to be applied to assets
    /// created by the job.
    asset_configuration: ?AssetConfiguration = null,

    /// The details for the CreateJob request.
    details: RequestDetails,

    /// The type of job to be created.
    @"type": Type,

    pub const json_field_names = .{
        .asset_configuration = "AssetConfiguration",
        .details = "Details",
        .@"type" = "Type",
    };
};

pub const CreateJobOutput = struct {
    /// The ARN for the job.
    arn: ?[]const u8 = null,

    /// The configuration for the asset, including tags applied to assets created by
    /// the job.
    asset_configuration: ?AssetConfiguration = null,

    /// The date and time that the job was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// Details about the job.
    details: ?ResponseDetails = null,

    /// The errors associated with jobs.
    errors: ?[]const JobError = null,

    /// The unique identifier for the job.
    id: ?[]const u8 = null,

    /// The state of the job.
    state: ?State = null,

    /// The job type.
    @"type": ?Type = null,

    /// The date and time that the job was last updated, in ISO 8601 format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_configuration = "AssetConfiguration",
        .created_at = "CreatedAt",
        .details = "Details",
        .errors = "Errors",
        .id = "Id",
        .state = "State",
        .@"type" = "Type",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobInput, options: CallOptions) !CreateJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dataexchange", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.asset_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AssetConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Details\":");
    try aws.json.writeValue(@TypeOf(input.details), input.details, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateJobOutput {
    var result: CreateJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
