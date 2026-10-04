const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExpirationModelType = @import("expiration_model_type.zig").ExpirationModelType;
const ImportType = @import("import_type.zig").ImportType;

pub const ImportKeyMaterialInput = struct {
    /// The encrypted key material to import. The key material must be encrypted
    /// under the public
    /// wrapping key that GetParametersForImport returned, using the wrapping
    /// algorithm that you specified in the same `GetParametersForImport` request.
    encrypted_key_material: []const u8,

    /// Specifies whether the key material expires. The default is
    /// `KEY_MATERIAL_EXPIRES`. For help with this choice, see [Setting
    /// an expiration
    /// time](https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys-import-key-material.html#importing-keys-expiration) in the *Key Management Service Developer Guide*.
    ///
    /// When the value of `ExpirationModel` is `KEY_MATERIAL_EXPIRES`, you
    /// must specify a value for the `ValidTo` parameter. When value is
    /// `KEY_MATERIAL_DOES_NOT_EXPIRE`, you must omit the `ValidTo`
    /// parameter.
    ///
    /// You cannot change the `ExpirationModel` or `ValidTo` values for the
    /// current import after the request completes. To change either value, you must
    /// reimport the key
    /// material.
    expiration_model: ?ExpirationModelType = null,

    /// The import token that you received in the response to a previous
    /// GetParametersForImport request. It must be from the same response that
    /// contained
    /// the public key that you used to encrypt the key material.
    import_token: []const u8,

    /// Indicates whether the key material being imported is previously associated
    /// with this KMS
    /// key or not. This parameter is optional and only usable with symmetric
    /// encryption keys. If no
    /// key material has ever been imported into the KMS key, and this parameter is
    /// omitted, the
    /// parameter defaults to `NEW_KEY_MATERIAL`. After the first key material is
    /// imported,
    /// if this parameter is omitted then the parameter defaults to
    /// `EXISTING_KEY_MATERIAL`.
    ///
    /// For multi-Region keys, you must first import new key material into
    /// the primary Region key. You should use the `NEW_KEY_MATERIAL` import type
    /// when importing key
    /// material into the primary Region key. Then, you can import the same key
    /// material into the replica Region
    /// key. The import type for the replica Region key should be
    /// `EXISTING_KEY_MATERIAL`.
    import_type: ?ImportType = null,

    /// The identifier of the KMS key that will be associated with the imported key
    /// material. This
    /// must be the same KMS key specified in the `KeyID` parameter of the
    /// corresponding
    /// GetParametersForImport request. The `Origin` of the KMS key
    /// must be `EXTERNAL` and its `KeyState` must be
    /// `PendingImport`.
    ///
    /// The KMS key can be a symmetric encryption KMS key, HMAC KMS key, asymmetric
    /// encryption KMS
    /// key, or asymmetric signing KMS key, including a [multi-Region
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-overview.html) of any supported
    /// type. You cannot perform this operation on a KMS key in a custom key store,
    /// or on a KMS key in
    /// a different Amazon Web Services account.
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

    /// Description for the key material being imported. This parameter is optional
    /// and only
    /// usable with symmetric encryption keys. If you do not specify a key material
    /// description, KMS
    /// retains the value you specified when you last imported the same key material
    /// into this KMS
    /// key.
    key_material_description: ?[]const u8 = null,

    /// Identifies the key material being imported. This parameter is optional and
    /// only usable
    /// with symmetric encryption keys. You cannot specify a key material ID with
    /// `ImportType` set to `NEW_KEY_MATERIAL`. Whenever you import key
    /// material into a symmetric encryption key, KMS assigns a unique identifier to
    /// the key
    /// material based on the KMS key ID and the imported key material. When you
    /// re-import key
    /// material with a specified key material ID, KMS:
    ///
    /// * Computes the identifier for the key material
    ///
    /// * Matches the computed identifier against the specified key material ID
    ///
    /// * Verifies that the key material ID is already associated with the KMS key
    ///
    /// To get the list of key material IDs associated with a KMS key, use
    /// ListKeyRotations.
    key_material_id: ?[]const u8 = null,

    /// The date and time when the imported key material expires. This parameter is
    /// required when
    /// the value of the `ExpirationModel` parameter is `KEY_MATERIAL_EXPIRES`.
    /// Otherwise it is not valid.
    ///
    /// The value of this parameter must be a future date and time. The maximum
    /// value is 365 days
    /// from the request date.
    ///
    /// When the key material expires, KMS deletes the key material from the KMS
    /// key. Without
    /// its key material, the KMS key is unusable. To use the KMS key in
    /// cryptographic operations, you
    /// must reimport the same key material.
    ///
    /// You cannot change the `ExpirationModel` or `ValidTo` values for the
    /// current import after the request completes. To change either value, you must
    /// delete (DeleteImportedKeyMaterial) and reimport the key material.
    valid_to: ?i64 = null,

    pub const json_field_names = .{
        .encrypted_key_material = "EncryptedKeyMaterial",
        .expiration_model = "ExpirationModel",
        .import_token = "ImportToken",
        .import_type = "ImportType",
        .key_id = "KeyId",
        .key_material_description = "KeyMaterialDescription",
        .key_material_id = "KeyMaterialId",
        .valid_to = "ValidTo",
    };
};

pub const ImportKeyMaterialOutput = struct {
    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the KMS key into which key material was imported.
    key_id: ?[]const u8 = null,

    /// Identifies the imported key material.
    key_material_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .key_material_id = "KeyMaterialId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportKeyMaterialInput, options: CallOptions) !ImportKeyMaterialOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportKeyMaterialInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.ImportKeyMaterial");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportKeyMaterialOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportKeyMaterialOutput, body, allocator);
}
