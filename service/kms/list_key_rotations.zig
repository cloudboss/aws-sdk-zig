const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncludeKeyMaterial = @import("include_key_material.zig").IncludeKeyMaterial;
const RotationsListEntry = @import("rotations_list_entry.zig").RotationsListEntry;

pub const ListKeyRotationsInput = struct {
    /// Use this optional parameter to control which key materials associated with
    /// this key are
    /// listed in the response. The default value of this parameter is
    /// `ROTATIONS_ONLY`. If
    /// you omit this parameter, KMS returns information on the key materials
    /// created by automatic
    /// or on-demand key rotation. When you specify a value of `ALL_KEY_MATERIAL`,
    /// KMS
    /// adds the first key material and any imported key material pending rotation
    /// to the response.
    /// This parameter can only be used with KMS keys that support automatic or
    /// on-demand key
    /// rotation.
    include_key_material: ?IncludeKeyMaterial = null,

    /// Gets the key rotations for the specified KMS key.
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

    /// Use this parameter to specify the maximum number of items to return. When
    /// this
    /// value is present, KMS does not return more than the specified number of
    /// items, but it might
    /// return fewer.
    ///
    /// This value is optional. If you include a value, it must be between
    /// 1 and 1000, inclusive. If you do not include a value, it defaults to 100.
    limit: ?i32 = null,

    /// Use this parameter in a subsequent request after you receive a response with
    /// truncated results. Set it to the value of `NextMarker` from the truncated
    /// response
    /// you just received.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_key_material = "IncludeKeyMaterial",
        .key_id = "KeyId",
        .limit = "Limit",
        .marker = "Marker",
    };
};

pub const ListKeyRotationsOutput = struct {
    /// When `Truncated` is true, this element is present and contains the
    /// value to use for the `Marker` parameter in a subsequent request.
    next_marker: ?[]const u8 = null,

    /// A list of completed key material rotations. When the optional input
    /// parameter
    /// `IncludeKeyMaterial` is specified with a value of `ALL_KEY_MATERIAL`,
    /// this list includes the first key material and any imported key material
    /// pending
    /// rotation.
    rotations: ?[]const RotationsListEntry = null,

    /// A flag that indicates whether there are more items in the list. When this
    /// value is true, the list in this response is truncated. To get more items,
    /// pass the value of
    /// the `NextMarker` element in this response to the `Marker` parameter in a
    /// subsequent request.
    truncated: ?bool = null,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .rotations = "Rotations",
        .truncated = "Truncated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListKeyRotationsInput, options: CallOptions) !ListKeyRotationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListKeyRotationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.ListKeyRotations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListKeyRotationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListKeyRotationsOutput, body, allocator);
}
