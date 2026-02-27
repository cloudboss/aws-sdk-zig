const OriginationRoute = @import("origination_route.zig").OriginationRoute;

/// Origination settings enable your SIP hosts to receive inbound calls using
/// your
/// Amazon Chime SDK Voice Connector.
///
/// The parameters listed below are not required, but you must use at least
/// one.
pub const Origination = struct {
    /// When origination settings are disabled, inbound calls are not enabled for
    /// your
    /// Amazon Chime SDK Voice Connector.
    /// This parameter is not required, but you must specify this parameter or
    /// `Routes`.
    disabled: ?bool,

    /// The call distribution properties defined for your SIP hosts. Valid range:
    /// Minimum
    /// value of 1. Maximum value of 20. This parameter is not required, but you
    /// must specify
    /// this parameter or `Disabled`.
    routes: ?[]const OriginationRoute,

    pub const json_field_names = .{
        .disabled = "Disabled",
        .routes = "Routes",
    };
};
