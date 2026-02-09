/// Configuration that specifies the permissions required for the capacity
/// provider to manage compute resources.
pub const CapacityProviderPermissionsConfig = struct {
    /// The ARN of the IAM role that the capacity provider uses to manage compute
    /// instances and other Amazon Web Services resources.
    capacity_provider_operator_role_arn: []const u8,
};
