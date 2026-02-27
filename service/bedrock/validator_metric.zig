/// The metric for the validator.
pub const ValidatorMetric = struct {
    /// The validation loss associated with this validator.
    validation_loss: ?f32,

    pub const json_field_names = .{
        .validation_loss = "validationLoss",
    };
};
