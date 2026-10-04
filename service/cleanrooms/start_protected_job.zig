const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProtectedJobComputeConfiguration = @import("protected_job_compute_configuration.zig").ProtectedJobComputeConfiguration;
const ProtectedJobParameters = @import("protected_job_parameters.zig").ProtectedJobParameters;
const ProtectedJobResultConfigurationInput = @import("protected_job_result_configuration_input.zig").ProtectedJobResultConfigurationInput;
const ProtectedJobType = @import("protected_job_type.zig").ProtectedJobType;
const ProtectedJob = @import("protected_job.zig").ProtectedJob;

pub const StartProtectedJobInput = struct {
    /// The compute configuration for the protected job.
    compute_configuration: ?ProtectedJobComputeConfiguration = null,

    /// The job parameters.
    job_parameters: ProtectedJobParameters,

    /// A unique identifier for the membership to run this job against. Currently
    /// accepts a membership ID.
    membership_identifier: []const u8,

    /// The details needed to write the job results.
    result_configuration: ?ProtectedJobResultConfigurationInput = null,

    /// The type of protected job to start.
    @"type": ProtectedJobType,

    pub const json_field_names = .{
        .compute_configuration = "computeConfiguration",
        .job_parameters = "jobParameters",
        .membership_identifier = "membershipIdentifier",
        .result_configuration = "resultConfiguration",
        .@"type" = "type",
    };
};

pub const StartProtectedJobOutput = struct {
    /// The protected job.
    protected_job: ?ProtectedJob = null,

    pub const json_field_names = .{
        .protected_job = "protectedJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartProtectedJobInput, options: CallOptions) !StartProtectedJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartProtectedJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/protectedJobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.compute_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"computeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobParameters\":");
    try aws.json.writeValue(@TypeOf(input.job_parameters), input.job_parameters, allocator, &body_buf);
    has_prev = true;
    if (input.result_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resultConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartProtectedJobOutput {
    var result: StartProtectedJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartProtectedJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
