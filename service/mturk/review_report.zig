const ReviewActionDetail = @import("review_action_detail.zig").ReviewActionDetail;
const ReviewResultDetail = @import("review_result_detail.zig").ReviewResultDetail;

/// Contains both ReviewResult and ReviewAction elements for a
/// particular HIT.
pub const ReviewReport = struct {
    /// A list of ReviewAction objects for each action specified in
    /// the Review Policy.
    review_actions: ?[]const ReviewActionDetail = null,

    /// A list of ReviewResults objects for each action specified in
    /// the Review Policy.
    review_results: ?[]const ReviewResultDetail = null,

    pub const json_field_names = .{
        .review_actions = "ReviewActions",
        .review_results = "ReviewResults",
    };
};
