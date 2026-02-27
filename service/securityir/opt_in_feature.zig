const OptInFeatureName = @import("opt_in_feature_name.zig").OptInFeatureName;

pub const OptInFeature = struct {
    feature_name: OptInFeatureName,

    is_enabled: bool,

    pub const json_field_names = .{
        .feature_name = "featureName",
        .is_enabled = "isEnabled",
    };
};
