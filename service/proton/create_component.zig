const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Component = @import("component.zig").Component;

pub const CreateComponentInput = struct {
    /// The client token for the created component.
    client_token: ?[]const u8 = null,

    /// An optional customer-provided description of the component.
    description: ?[]const u8 = null,

    /// The name of the Proton environment that you want to associate this component
    /// with. You must specify this when you don't specify
    /// `serviceInstanceName` and `serviceName`.
    environment_name: ?[]const u8 = null,

    /// A path to a manifest file that lists the Infrastructure as Code (IaC) file,
    /// template language, and rendering engine for infrastructure that a custom
    /// component provisions.
    manifest: []const u8,

    /// The customer-provided name of the component.
    name: []const u8,

    /// The name of the service instance that you want to attach this component to.
    /// If you don't specify this, the component isn't attached to any service
    /// instance. Specify both `serviceInstanceName` and `serviceName` or neither of
    /// them.
    service_instance_name: ?[]const u8 = null,

    /// The name of the service that `serviceInstanceName` is associated with. If
    /// you don't specify this, the component isn't attached to any
    /// service instance. Specify both `serviceInstanceName` and `serviceName` or
    /// neither of them.
    service_name: ?[]const u8 = null,

    /// The service spec that you want the component to use to access service
    /// inputs. Set this only when you attach the component to a service
    /// instance.
    service_spec: ?[]const u8 = null,

    /// An optional list of metadata items that you can associate with the Proton
    /// component. A tag is a key-value pair.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in the
    /// *Proton User Guide*.
    tags: ?[]const Tag = null,

    /// A path to the Infrastructure as Code (IaC) file describing infrastructure
    /// that a custom component provisions.
    ///
    /// Components support a single IaC file, even if you use Terraform as your
    /// template language.
    template_file: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .environment_name = "environmentName",
        .manifest = "manifest",
        .name = "name",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
        .service_spec = "serviceSpec",
        .tags = "tags",
        .template_file = "templateFile",
    };
};

pub const CreateComponentOutput = struct {
    /// The detailed data of the created component.
    component: ?Component = null,

    pub const json_field_names = .{
        .component = "component",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateComponentInput, options: CallOptions) !CreateComponentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateComponentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.CreateComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateComponentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateComponentOutput, body, allocator);
}
