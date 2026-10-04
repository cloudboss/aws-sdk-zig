/// A reference to a specific result item.
pub const AgenticRetrieveCitationReference = struct {
    /// Index into the results array on the same event.
    result_index: i32,

    pub const json_field_names = .{
        .result_index = "resultIndex",
    };
};
