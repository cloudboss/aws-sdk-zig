/// The amount of ephemeral storage to allocate for the deployment.
pub const DeploymentEphemeralStorage = struct {
    /// Specify an Key
    /// Management Service key ID to encrypt the ephemeral storage for
    /// deployment.
    kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
    };
};
