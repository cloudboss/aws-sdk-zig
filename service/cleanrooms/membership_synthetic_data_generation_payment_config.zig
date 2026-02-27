/// Configuration for payment for synthetic data generation in a membership.
pub const MembershipSyntheticDataGenerationPaymentConfig = struct {
    /// Indicates if this membership is responsible for paying for synthetic data
    /// generation.
    is_responsible: bool,

    pub const json_field_names = .{
        .is_responsible = "isResponsible",
    };
};
