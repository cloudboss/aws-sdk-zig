const CustomerManagedAwsSecretConfiguration = @import("customer_managed_aws_secret_configuration.zig").CustomerManagedAwsSecretConfiguration;

/// The configuration of the admin password source. This is a union, so only one
/// of the following members can be specified.
pub const AdminPasswordSourceConfiguration = union(enum) {
    /// The configuration for a customer-managed Amazon Web Services Secrets Manager
    /// secret used as the admin password source.
    customer_managed_aws_secret: ?CustomerManagedAwsSecretConfiguration,

    pub const json_field_names = .{
        .customer_managed_aws_secret = "customerManagedAwsSecret",
    };
};
