/// Information about automatic fail configuration for an evaluation form.
pub const AutomaticFailConfiguration = struct {
    /// The referenceId of the target section for auto failure.
    target_section: ?[]const u8,

    pub const json_field_names = .{
        .target_section = "TargetSection",
    };
};
