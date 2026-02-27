/// Contains information about whether the result of a previous query was
/// reused.
pub const ResultReuseInformation = struct {
    /// True if a previous query result was reused; false if the result was
    /// generated from a
    /// new run of the query.
    reused_previous_result: bool = false,

    pub const json_field_names = .{
        .reused_previous_result = "ReusedPreviousResult",
    };
};
