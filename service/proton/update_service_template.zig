const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceTemplate = @import("service_template.zig").ServiceTemplate;

pub const UpdateServiceTemplateInput = struct {
    /// A description of the service template update.
    description: ?[]const u8 = null,

    /// The name of the service template to update that's displayed in the developer
    /// interface.
    display_name: ?[]const u8 = null,

    /// The name of the service template to update.
    name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .name = "name",
    };
};

pub const UpdateServiceTemplateOutput = struct {
    /// The service template detail data that's returned by Proton.
    service_template: ?ServiceTemplate = null,

    pub const json_field_names = .{
        .service_template = "serviceTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceTemplateInput, options: CallOptions) !UpdateServiceTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceTemplateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateServiceTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceTemplateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateServiceTemplateOutput, body, allocator);
}
