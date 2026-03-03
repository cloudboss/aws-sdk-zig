/// Specifies whether previous query results are reused, and if so, their
/// maximum
/// age.
pub const ResultReuseByAgeConfiguration = struct {
    /// True if previous query results can be reused when the query is run;
    /// otherwise, false.
    /// The default is false.
    enabled: bool = false,

    /// Specifies, in minutes, the maximum age of a previous query result that
    /// Athena should consider for reuse. The default is 60.
    max_age_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .max_age_in_minutes = "MaxAgeInMinutes",
    };
};
