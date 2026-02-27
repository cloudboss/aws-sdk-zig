pub const SlotResolutionStrategy = enum {
    enhanced_fallback,
    default,

    pub const json_field_names = .{
        .enhanced_fallback = "EnhancedFallback",
        .default = "Default",
    };
};
