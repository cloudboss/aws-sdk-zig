const TopicIR = @import("topic_ir.zig").TopicIR;
const VisualRole = @import("visual_role.zig").VisualRole;

/// The definition for a `TopicVisual`.
pub const TopicVisual = struct {
    /// The ir for the `TopicVisual`.
    ir: ?TopicIR = null,

    /// The role for the `TopicVisual`.
    role: ?VisualRole = null,

    /// The supporting visuals for the `TopicVisual`.
    supporting_visuals: ?[]const TopicVisual = null,

    /// The visual ID for the `TopicVisual`.
    visual_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ir = "Ir",
        .role = "Role",
        .supporting_visuals = "SupportingVisuals",
        .visual_id = "VisualId",
    };
};
