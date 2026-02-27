/// The function used to train an `MLModel`. Training choices supported by
/// Amazon ML include the following:
///
/// * `SGD` - Stochastic Gradient Descent.
///
/// * `RandomForest` - Random forest of decision trees.
pub const Algorithm = enum {
    sgd,

    pub const json_field_names = .{
        .sgd = "SGD",
    };
};
