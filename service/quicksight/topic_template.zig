const Slot = @import("slot.zig").Slot;

/// The definition for a `TopicTemplate`.
pub const TopicTemplate = struct {
    /// The slots for the `TopicTemplate`.
    slots: ?[]const Slot = null,

    /// The template type for the `TopicTemplate`.
    template_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .slots = "Slots",
        .template_type = "TemplateType",
    };
};
