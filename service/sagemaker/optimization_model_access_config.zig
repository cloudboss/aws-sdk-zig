/// The access configuration settings for the source ML model for an
/// optimization job, where you can accept the model end-user license agreement
/// (EULA).
pub const OptimizationModelAccessConfig = struct {
    /// Specifies agreement to the model end-user license agreement (EULA). The
    /// `AcceptEula` value must be explicitly defined as `True` in order to accept
    /// the EULA that this model requires. You are responsible for reviewing and
    /// complying with any applicable license terms and making sure they are
    /// acceptable for your use case before downloading or using a model.
    accept_eula: bool,

    pub const json_field_names = .{
        .accept_eula = "AcceptEula",
    };
};
