/// Encryption configuration for MediaConnect router. When using SECRETS_MANAGER
/// encryption, you must provide the ARN of the secret used to encrypt data in
/// transit. When using AUTOMATIC encryption, a service-managed secret will be
/// used instead.
pub const RouterEncryptionType = enum {
    automatic,
    secrets_manager,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .secrets_manager = "SECRETS_MANAGER",
    };
};
