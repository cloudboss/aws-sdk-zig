const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionKey = @import("encryption_key.zig").EncryptionKey;
const MergeStrategy = @import("merge_strategy.zig").MergeStrategy;
const Tag = @import("tag.zig").Tag;
const TerminologyData = @import("terminology_data.zig").TerminologyData;
const TerminologyDataLocation = @import("terminology_data_location.zig").TerminologyDataLocation;
const TerminologyProperties = @import("terminology_properties.zig").TerminologyProperties;

pub const ImportTerminologyInput = struct {
    /// The description of the custom terminology being imported.
    description: ?[]const u8 = null,

    /// The encryption key for the custom terminology being imported.
    encryption_key: ?EncryptionKey = null,

    /// The merge strategy of the custom terminology being imported. Currently, only
    /// the OVERWRITE
    /// merge strategy is supported. In this case, the imported terminology will
    /// overwrite an existing
    /// terminology of the same name.
    merge_strategy: MergeStrategy,

    /// The name of the custom terminology being imported.
    name: []const u8,

    /// Tags to be associated with this resource. A tag is a key-value pair that
    /// adds metadata to a resource. Each tag key for the resource must be unique.
    /// For more information, see [
    /// Tagging your
    /// resources](https://docs.aws.amazon.com/translate/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    /// The terminology data for the custom terminology being imported.
    terminology_data: TerminologyData,

    pub const json_field_names = .{
        .description = "Description",
        .encryption_key = "EncryptionKey",
        .merge_strategy = "MergeStrategy",
        .name = "Name",
        .tags = "Tags",
        .terminology_data = "TerminologyData",
    };
};

pub const ImportTerminologyOutput = struct {
    /// The Amazon S3 location of a file that provides any errors or warnings that
    /// were produced
    /// by your input file. This file was created when Amazon Translate attempted to
    /// create a
    /// terminology resource. The location is returned as a presigned URL to that
    /// has a 30 minute
    /// expiration.
    auxiliary_data_location: ?TerminologyDataLocation = null,

    /// The properties of the custom terminology being imported.
    terminology_properties: ?TerminologyProperties = null,

    pub const json_field_names = .{
        .auxiliary_data_location = "AuxiliaryDataLocation",
        .terminology_properties = "TerminologyProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportTerminologyInput, options: CallOptions) !ImportTerminologyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "translate", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportTerminologyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("translate", "Translate", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShineFrontendService_20170701.ImportTerminology");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportTerminologyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportTerminologyOutput, body, allocator);
}
