const Algorithm = @import("algorithm.zig").Algorithm;
const KeyType = @import("key_type.zig").KeyType;

/// Information about the encryption of the flow.
pub const UpdateEncryption = struct {
    /// The type of algorithm that is used for the encryption (such as aes128,
    /// aes192, or aes256).
    algorithm: ?Algorithm,

    /// A 128-bit, 16-byte hex value represented by a 32-character string, to be
    /// used with the key for encrypting content. This parameter is not valid for
    /// static key encryption.
    constant_initialization_vector: ?[]const u8,

    /// The value of one of the devices that you configured with your digital rights
    /// management (DRM) platform key provider. This parameter is required for SPEKE
    /// encryption and is not valid for static key encryption.
    device_id: ?[]const u8,

    /// The type of key that is used for the encryption. If no keyType is provided,
    /// the service will use the default setting (static-key).
    key_type: ?KeyType,

    /// The Amazon Web Services Region that the API Gateway proxy endpoint was
    /// created in. This parameter is required for SPEKE encryption and is not valid
    /// for static key encryption.
    region: ?[]const u8,

    /// An identifier for the content. The service sends this value to the key
    /// server to identify the current endpoint. The resource ID is also known as
    /// the content ID. This parameter is required for SPEKE encryption and is not
    /// valid for static key encryption.
    resource_id: ?[]const u8,

    /// The ARN of the role that you created during setup (when you set up
    /// MediaConnect as a trusted entity).
    role_arn: ?[]const u8,

    /// The ARN of the secret that you created in Secrets Manager to store the
    /// encryption key. This parameter is required for static key encryption and is
    /// not valid for SPEKE encryption.
    secret_arn: ?[]const u8,

    /// The URL from the API Gateway proxy that you set up to talk to your key
    /// server. This parameter is required for SPEKE encryption and is not valid for
    /// static key encryption.
    url: ?[]const u8,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .constant_initialization_vector = "ConstantInitializationVector",
        .device_id = "DeviceId",
        .key_type = "KeyType",
        .region = "Region",
        .resource_id = "ResourceId",
        .role_arn = "RoleArn",
        .secret_arn = "SecretArn",
        .url = "Url",
    };
};
