pub const OverrideType = enum {
    semantic_override,
    summary_override,
    user_preference_override,
    self_managed,
    episodic_override,

    pub const json_field_names = .{
        .semantic_override = "SEMANTIC_OVERRIDE",
        .summary_override = "SUMMARY_OVERRIDE",
        .user_preference_override = "USER_PREFERENCE_OVERRIDE",
        .self_managed = "SELF_MANAGED",
        .episodic_override = "EPISODIC_OVERRIDE",
    };
};
