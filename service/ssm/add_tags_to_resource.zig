const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTypeForTagging = @import("resource_type_for_tagging.zig").ResourceTypeForTagging;
const Tag = @import("tag.zig").Tag;

pub const AddTagsToResourceInput = struct {
    /// The resource ID you want to tag.
    ///
    /// Use the ID of the resource. Here are some examples:
    ///
    /// `MaintenanceWindow`: `mw-012345abcde`
    ///
    /// `PatchBaseline`: `pb-012345abcde`
    ///
    /// `Automation`: `example-c160-4567-8519-012345abcde`
    ///
    /// `OpsMetadata` object: `ResourceID` for tagging is created from the
    /// Amazon Resource Name (ARN) for the object. Specifically, `ResourceID` is
    /// created from
    /// the strings that come after the word `opsmetadata` in the ARN. For example,
    /// an
    /// OpsMetadata object with an ARN of
    /// `arn:aws:ssm:us-east-2:1234567890:opsmetadata/aws/ssm/MyGroup/appmanager`
    /// has a
    /// `ResourceID` of either `aws/ssm/MyGroup/appmanager` or
    /// `/aws/ssm/MyGroup/appmanager`.
    ///
    /// For the `Document` and `Parameter` values, use the name of the
    /// resource. If you're tagging a shared document, you must use the full ARN of
    /// the document.
    ///
    /// `ManagedInstance`: `mi-012345abcde`
    ///
    /// The `ManagedInstance` type for this API operation is only for on-premises
    /// managed nodes. You must specify the name of the managed node in the
    /// following format:
    /// `mi-*ID_number*
    /// `. For example,
    /// `mi-1a2b3c4d5e6f`.
    resource_id: []const u8,

    /// Specifies the type of resource you are tagging.
    ///
    /// The `ManagedInstance` type for this API operation is for on-premises managed
    /// nodes. You must specify the name of the managed node in the following
    /// format:
    /// `mi-*ID_number*
    /// `. For example,
    /// `mi-1a2b3c4d5e6f`.
    resource_type: ResourceTypeForTagging,

    /// One or more tags. The value parameter is required.
    ///
    /// Don't enter personally identifiable information in this field.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .tags = "Tags",
    };
};

pub const AddTagsToResourceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddTagsToResourceInput, options: CallOptions) !AddTagsToResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddTagsToResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.AddTagsToResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddTagsToResourceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
