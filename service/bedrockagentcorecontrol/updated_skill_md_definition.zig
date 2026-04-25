const SkillMdDefinition = @import("skill_md_definition.zig").SkillMdDefinition;

/// Wrapper for updating a skill markdown definition with PATCH semantics.
pub const UpdatedSkillMdDefinition = struct {
    /// The updated skill markdown definition value.
    optional_value: ?SkillMdDefinition = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
