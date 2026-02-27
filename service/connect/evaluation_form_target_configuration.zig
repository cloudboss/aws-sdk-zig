const ContactInteractionType = @import("contact_interaction_type.zig").ContactInteractionType;

/// Configuration that specifies the target for an evaluation form.
pub const EvaluationFormTargetConfiguration = struct {
    /// The contact interaction type for this evaluation form.
    contact_interaction_type: ContactInteractionType,

    pub const json_field_names = .{
        .contact_interaction_type = "ContactInteractionType",
    };
};
