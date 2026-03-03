/// Information about the lifecycle policy for the repository.
pub const AwsEcrRepositoryLifecyclePolicyDetails = struct {
    /// The text of the lifecycle policy.
    lifecycle_policy_text: ?[]const u8 = null,

    /// The Amazon Web Services account identifier that is associated with the
    /// registry that contains the repository.
    registry_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle_policy_text = "LifecyclePolicyText",
        .registry_id = "RegistryId",
    };
};
