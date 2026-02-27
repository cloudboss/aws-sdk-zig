/// The name and an example value of the hyperparameter that you want to use in
/// Autotune. If Automatic model tuning (AMT) determines that your
/// hyperparameter is eligible for Autotune, an optimal hyperparameter range is
/// selected for you.
pub const AutoParameter = struct {
    /// The name of the hyperparameter to optimize using Autotune.
    name: []const u8,

    /// An example value of the hyperparameter to optimize using Autotune.
    value_hint: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value_hint = "ValueHint",
    };
};
