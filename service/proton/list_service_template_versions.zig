const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceTemplateVersionSummary = @import("service_template_version_summary.zig").ServiceTemplateVersionSummary;

pub const ListServiceTemplateVersionsInput = struct {
    /// To view a list of minor of versions under a major version of a service
    /// template, include
    /// `major Version`.
    ///
    /// To view a list of major versions of a service template, *exclude*
    /// `major Version`.
    major_version: ?[]const u8 = null,

    /// The maximum number of major or minor versions of a service template to list.
    max_results: ?i32 = null,

    /// A token that indicates the location of the next major or minor version in
    /// the array of
    /// major or minor versions of a service template, after the list of major or
    /// minor versions that
    /// was previously requested.
    next_token: ?[]const u8 = null,

    /// The name of the service template.
    template_name: []const u8,

    pub const json_field_names = .{
        .major_version = "majorVersion",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .template_name = "templateName",
    };
};

pub const ListServiceTemplateVersionsOutput = struct {
    /// A token that indicates the location of the next major or minor version in
    /// the array of
    /// major or minor versions of a service template, after the current requested
    /// list of service
    /// major or minor versions.
    next_token: ?[]const u8 = null,

    /// An array of major or minor versions of a service template with detail data.
    template_versions: ?[]const ServiceTemplateVersionSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .template_versions = "templateVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceTemplateVersionsInput, options: CallOptions) !ListServiceTemplateVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceTemplateVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListServiceTemplateVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceTemplateVersionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListServiceTemplateVersionsOutput, body, allocator);
}
