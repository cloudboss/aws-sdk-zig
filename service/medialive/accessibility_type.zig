/// Accessibility Type
pub const AccessibilityType = enum {
    does_not_implement_accessibility_features,
    implements_accessibility_features,

    pub const json_field_names = .{
        .does_not_implement_accessibility_features = "DOES_NOT_IMPLEMENT_ACCESSIBILITY_FEATURES",
        .implements_accessibility_features = "IMPLEMENTS_ACCESSIBILITY_FEATURES",
    };
};
