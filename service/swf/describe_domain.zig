const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainConfiguration = @import("domain_configuration.zig").DomainConfiguration;
const DomainInfo = @import("domain_info.zig").DomainInfo;

pub const DescribeDomainInput = struct {
    /// The name of the domain to describe.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const DescribeDomainOutput = struct {
    /// The domain configuration. Currently, this includes only the domain's
    /// retention
    /// period.
    configuration: ?DomainConfiguration = null,

    /// The basic information about a domain, such as its name, status, and
    /// description.
    domain_info: ?DomainInfo = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .domain_info = "domainInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDomainInput, options: CallOptions) !DescribeDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDomainInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.DescribeDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDomainOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeDomainOutput, body, allocator);
}
