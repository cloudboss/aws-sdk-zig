const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteImportedKeyMaterialInput = struct {
    /// Identifies the KMS key from which you are deleting imported key material.
    /// The
    /// `Origin` of the KMS key must be `EXTERNAL`.
    ///
    /// Specify the key ID or key ARN of the KMS key.
    ///
    /// For example:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey.
    key_id: []const u8,

    /// Identifies the imported key material you are deleting.
    ///
    /// If no KeyMaterialId is specified, KMS deletes the current key material.
    ///
    /// To get the list of key material IDs associated with a KMS key, use
    /// ListKeyRotations.
    key_material_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .key_material_id = "KeyMaterialId",
    };
};

pub const DeleteImportedKeyMaterialOutput = struct {
    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the KMS key from which the key material was deleted.
    key_id: ?[]const u8 = null,

    /// Identifies the deleted key material.
    key_material_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .key_material_id = "KeyMaterialId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteImportedKeyMaterialInput, options: CallOptions) !DeleteImportedKeyMaterialOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteImportedKeyMaterialInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kms", "KMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.DeleteImportedKeyMaterial");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteImportedKeyMaterialOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteImportedKeyMaterialOutput, body, allocator);
}
