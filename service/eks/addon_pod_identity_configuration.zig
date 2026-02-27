/// Information about how to configure IAM for an add-on.
pub const AddonPodIdentityConfiguration = struct {
    /// A suggested IAM Policy for the add-on.
    recommended_managed_policies: ?[]const []const u8,

    /// The Kubernetes Service Account name used by the add-on.
    service_account: ?[]const u8,

    pub const json_field_names = .{
        .recommended_managed_policies = "recommendedManagedPolicies",
        .service_account = "serviceAccount",
    };
};
