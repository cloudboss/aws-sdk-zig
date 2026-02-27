const SharedViewConfigurations = @import("shared_view_configurations.zig").SharedViewConfigurations;

/// The feature configuration for an embedded dashboard.
pub const AnonymousUserDashboardFeatureConfigurations = struct {
    /// The shared view settings of an embedded dashboard.
    shared_view: ?SharedViewConfigurations,

    pub const json_field_names = .{
        .shared_view = "SharedView",
    };
};
