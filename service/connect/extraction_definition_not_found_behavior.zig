const NotFoundBehaviorType = @import("not_found_behavior_type.zig").NotFoundBehaviorType;

/// The behavior configuration when an extraction definition cannot find the
/// target value.
pub const ExtractionDefinitionNotFoundBehavior = struct {
    /// The behavior type. `USE_DEFAULT_VALUE` returns the specified default value.
    /// `OMIT` excludes the field from the output.
    behavior: NotFoundBehaviorType,

    /// The default value to use when the behavior is `USE_DEFAULT_VALUE`.
    default_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .behavior = "Behavior",
        .default_value = "DefaultValue",
    };
};
