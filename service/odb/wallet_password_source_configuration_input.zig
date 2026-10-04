const CustomerManagedAwsSecretConfigurationInput = @import("customer_managed_aws_secret_configuration_input.zig").CustomerManagedAwsSecretConfigurationInput;

/// The input configuration for the wallet password source. This is a union, so
/// only one of the following members can be specified.
pub const WalletPasswordSourceConfigurationInput = union(enum) {
    /// The configuration for using a customer-managed Amazon Web Services Secrets
    /// Manager secret as the wallet password source.
    customer_managed_aws_secret: ?CustomerManagedAwsSecretConfigurationInput,

    pub const json_field_names = .{
        .customer_managed_aws_secret = "customerManagedAwsSecret",
    };
};
