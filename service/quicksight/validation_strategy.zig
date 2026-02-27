const ValidationStrategyMode = @import("validation_strategy_mode.zig").ValidationStrategyMode;

/// The option to relax the validation that is required to create and update
/// analyses, dashboards, and templates with definition objects. When you set
/// this value to `LENIENT`, validation is skipped for specific errors.
pub const ValidationStrategy = struct {
    /// The mode of validation for the asset to be created or updated. When you set
    /// this value to `STRICT`, strict validation for every error is enforced. When
    /// you set this value to `LENIENT`, validation is skipped for specific UI
    /// errors.
    mode: ValidationStrategyMode,

    pub const json_field_names = .{
        .mode = "Mode",
    };
};
