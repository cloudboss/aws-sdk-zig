const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Provisioning = @import("provisioning.zig").Provisioning;
const Tag = @import("tag.zig").Tag;
const EnvironmentTemplate = @import("environment_template.zig").EnvironmentTemplate;

pub const CreateEnvironmentTemplateInput = struct {
    /// A description of the environment template.
    description: ?[]const u8 = null,

    /// The environment template name as displayed in the developer interface.
    display_name: ?[]const u8 = null,

    /// A customer provided encryption key that Proton uses to encrypt data.
    encryption_key: ?[]const u8 = null,

    /// The name of the environment template.
    name: []const u8,

    /// When included, indicates that the environment template is for customer
    /// provisioned and managed infrastructure.
    provisioning: ?Provisioning = null,

    /// An optional list of metadata items that you can associate with the Proton
    /// environment template. A tag is a key-value pair.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in the
    /// *Proton User Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .encryption_key = "encryptionKey",
        .name = "name",
        .provisioning = "provisioning",
        .tags = "tags",
    };
};

pub const CreateEnvironmentTemplateOutput = struct {
    /// The environment template detail data that's returned by Proton.
    environment_template: ?EnvironmentTemplate = null,

    pub const json_field_names = .{
        .environment_template = "environmentTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentTemplateInput, options: CallOptions) !CreateEnvironmentTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentTemplateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.CreateEnvironmentTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentTemplateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateEnvironmentTemplateOutput, body, allocator);
}
