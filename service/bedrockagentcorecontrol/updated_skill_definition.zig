const SkillDefinition = @import("skill_definition.zig").SkillDefinition;

/// Wrapper for updating a skill definition with PATCH semantics.
pub const UpdatedSkillDefinition = struct {
    /// The updated skill definition value.
    optional_value: ?SkillDefinition = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
