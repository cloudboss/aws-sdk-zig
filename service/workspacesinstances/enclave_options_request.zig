/// Configures AWS Nitro Enclave options for the WorkSpace Instance.
pub const EnclaveOptionsRequest = struct {
    /// Enables or disables AWS Nitro Enclaves for enhanced security.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
