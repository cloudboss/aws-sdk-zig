/// The recommended status to update for the specified recommendation action ID.
pub const RecommendedActionUpdate = struct {
    /// A unique identifier of the updated recommendation action.
    action_id: []const u8,

    /// The status of the updated recommendation action.
    ///
    /// * `applied`
    /// * `scheduled`
    status: []const u8,
};
