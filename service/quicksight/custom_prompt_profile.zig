/// A reference to an existing custom prompt profile.
pub const CustomPromptProfile = struct {
    /// The identifier of the model profile.
    model_profile_id: []const u8,

    /// The Amazon Web Services account ID for the Q Business service.
    qbs_aws_account_id: []const u8,

    /// The subscription identifier.
    subscription_id: []const u8,

    pub const json_field_names = .{
        .model_profile_id = "ModelProfileId",
        .qbs_aws_account_id = "QbsAwsAccountId",
        .subscription_id = "SubscriptionId",
    };
};
