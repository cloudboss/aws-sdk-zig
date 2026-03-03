/// Indicates whether the instance is enabled for Amazon Web Services Nitro
/// Enclaves. For more
/// information, see [What is Nitro
/// Enclaves?](https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html) in the
/// *Amazon Web Services Nitro Enclaves User Guide*.
pub const LaunchTemplateEnclaveOptionsRequest = struct {
    /// To enable the instance for Amazon Web Services Nitro Enclaves, set this
    /// parameter to
    /// `true`.
    enabled: ?bool = null,
};
