const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceMapping = @import("resource_mapping.zig").ResourceMapping;

pub const AddDraftAppVersionResourceMappingsInput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// Mappings used to map logical resources from the template to physical
    /// resources. You can
    /// use the mapping type `CFN_STACK` if the application template uses
    /// a logical stack name. Or you can map individual resources by using the
    /// mapping type
    /// `RESOURCE`. We recommend using the mapping type `CFN_STACK` if the
    /// application is backed by a CloudFormation stack.
    resource_mappings: []const ResourceMapping,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .resource_mappings = "resourceMappings",
    };
};

pub const AddDraftAppVersionResourceMappingsOutput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// The version of the application.
    app_version: []const u8,

    /// List of sources that are used to map a logical resource from the template to
    /// a physical
    /// resource. You can use sources such as CloudFormation, Terraform state files,
    /// AppRegistry applications, or Amazon EKS.
    resource_mappings: ?[]const ResourceMapping = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_version = "appVersion",
        .resource_mappings = "resourceMappings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddDraftAppVersionResourceMappingsInput, options: CallOptions) !AddDraftAppVersionResourceMappingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddDraftAppVersionResourceMappingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/add-draft-app-version-resource-mappings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appArn\":");
    try aws.json.writeValue(@TypeOf(input.app_arn), input.app_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceMappings\":");
    try aws.json.writeValue(@TypeOf(input.resource_mappings), input.resource_mappings, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddDraftAppVersionResourceMappingsOutput {
    var result: AddDraftAppVersionResourceMappingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AddDraftAppVersionResourceMappingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
