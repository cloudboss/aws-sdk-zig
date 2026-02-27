/// Payment configuration for synthetic data generation.
pub const SyntheticDataGenerationPaymentConfig = struct {
    /// Indicates who is responsible for paying for synthetic data generation.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
