/// The epsilon and noise parameter values that you want to use for the
/// differential privacy template.
pub const DifferentialPrivacyTemplateParametersInput = struct {
    /// The epsilon value that you want to use.
    epsilon: i32,

    /// Noise added per query is measured in terms of the number of users whose
    /// contributions you want to obscure. This value governs the rate at which the
    /// privacy budget is depleted.
    users_noise_per_query: i32,

    pub const json_field_names = .{
        .epsilon = "epsilon",
        .users_noise_per_query = "usersNoisePerQuery",
    };
};
