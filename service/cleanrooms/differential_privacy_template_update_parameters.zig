/// The epsilon and noise parameter values that you want to update in the
/// differential privacy template.
pub const DifferentialPrivacyTemplateUpdateParameters = struct {
    /// The updated epsilon value that you want to use.
    epsilon: ?i32,

    /// The updated value of noise added per query. It is measured in terms of the
    /// number of users whose contributions you want to obscure. This value governs
    /// the rate at which the privacy budget is depleted.
    users_noise_per_query: ?i32,

    pub const json_field_names = .{
        .epsilon = "epsilon",
        .users_noise_per_query = "usersNoisePerQuery",
    };
};
