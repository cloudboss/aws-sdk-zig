const TlsEncryptionConfiguration = @import("tls_encryption_configuration.zig").TlsEncryptionConfiguration;
const TlsEncryptionType = @import("tls_encryption_type.zig").TlsEncryptionType;

/// The Transport Layer Security (TLS) encryption settings used to establish a
/// secure connection to a destination.
pub const TlsEncryption = struct {
    /// The configuration settings for the specified TLS encryption type.
    encryption_configuration: TlsEncryptionConfiguration,

    /// The type of TLS encryption to use for the connection.
    encryption_type: ?TlsEncryptionType = null,

    pub const json_field_names = .{
        .encryption_configuration = "EncryptionConfiguration",
        .encryption_type = "EncryptionType",
    };
};
