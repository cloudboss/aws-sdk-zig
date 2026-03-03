/// The selected pillar.
pub const SelectedPillar = struct {
    pillar_id: ?[]const u8 = null,

    /// Selected question IDs in the selected pillar.
    selected_question_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .pillar_id = "PillarId",
        .selected_question_ids = "SelectedQuestionIds",
    };
};
