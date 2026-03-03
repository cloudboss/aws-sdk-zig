const DeltaTimeSessionWindowConfiguration = @import("delta_time_session_window_configuration.zig").DeltaTimeSessionWindowConfiguration;

/// The information needed to configure a delta time session window.
pub const LateDataRuleConfiguration = struct {
    /// The information needed to configure a delta time session window.
    delta_time_session_window_configuration: ?DeltaTimeSessionWindowConfiguration = null,

    pub const json_field_names = .{
        .delta_time_session_window_configuration = "deltaTimeSessionWindowConfiguration",
    };
};
