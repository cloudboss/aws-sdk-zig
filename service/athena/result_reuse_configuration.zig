const ResultReuseByAgeConfiguration = @import("result_reuse_by_age_configuration.zig").ResultReuseByAgeConfiguration;

/// Specifies the query result reuse behavior for the query.
pub const ResultReuseConfiguration = struct {
    /// Specifies whether previous query results are reused, and if so, their
    /// maximum
    /// age.
    result_reuse_by_age_configuration: ?ResultReuseByAgeConfiguration,

    pub const json_field_names = .{
        .result_reuse_by_age_configuration = "ResultReuseByAgeConfiguration",
    };
};
