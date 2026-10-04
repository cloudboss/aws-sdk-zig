const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportJobProperties = @import("export_job_properties.zig").ExportJobProperties;

pub const DescribeFHIRExportJobInput = struct {
    /// The data store identifier from which FHIR data is being exported from.
    datastore_id: []const u8,

    /// The export job identifier.
    job_id: []const u8,

    pub const json_field_names = .{
        .datastore_id = "DatastoreId",
        .job_id = "JobId",
    };
};

pub const DescribeFHIRExportJobOutput = struct {
    /// The export job properties.
    export_job_properties: ?ExportJobProperties = null,

    pub const json_field_names = .{
        .export_job_properties = "ExportJobProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFHIRExportJobInput, options: CallOptions) !DescribeFHIRExportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFHIRExportJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.DescribeFHIRExportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFHIRExportJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeFHIRExportJobOutput, body, allocator);
}
