const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MappingType = @import("mapping_type.zig").MappingType;
const S3Location = @import("s3_location.zig").S3Location;
const TemplateDetails = @import("template_details.zig").TemplateDetails;

pub const CreateStarterMappingTemplateInput = struct {
    /// Specify the format for the mapping template: either JSONATA or XSLT.
    mapping_type: MappingType,

    /// Specify the location of the sample EDI file that is used to generate the
    /// mapping template.
    output_sample_location: ?S3Location = null,

    /// Describes the details needed for generating the template. Specify the X12
    /// transaction set and version for which the template is used: currently, we
    /// only support X12.
    template_details: TemplateDetails,

    pub const json_field_names = .{
        .mapping_type = "mappingType",
        .output_sample_location = "outputSampleLocation",
        .template_details = "templateDetails",
    };
};

pub const CreateStarterMappingTemplateOutput = struct {
    /// Returns a string that represents the mapping template.
    mapping_template: []const u8,

    pub const json_field_names = .{
        .mapping_template = "mappingTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStarterMappingTemplateInput, options: CallOptions) !CreateStarterMappingTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "b2bi", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStarterMappingTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("b2bi", "b2bi", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.CreateStarterMappingTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStarterMappingTemplateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateStarterMappingTemplateOutput, body, allocator);
}
