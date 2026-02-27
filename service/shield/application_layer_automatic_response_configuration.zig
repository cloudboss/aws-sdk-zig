const ResponseAction = @import("response_action.zig").ResponseAction;
const ApplicationLayerAutomaticResponseStatus = @import("application_layer_automatic_response_status.zig").ApplicationLayerAutomaticResponseStatus;

/// The automatic application layer DDoS mitigation settings for a Protection.
/// This configuration determines whether Shield Advanced automatically
/// manages rules in the web ACL in order to respond to application layer events
/// that Shield Advanced determines to be DDoS attacks.
pub const ApplicationLayerAutomaticResponseConfiguration = struct {
    /// Specifies the action setting that Shield Advanced should use in the WAF
    /// rules that it creates on behalf of the
    /// protected resource in response to DDoS attacks. You specify this as part of
    /// the configuration for the automatic application layer DDoS mitigation
    /// feature,
    /// when you enable or update automatic mitigation. Shield Advanced creates the
    /// WAF rules in a Shield Advanced-managed rule group, inside the web ACL that
    /// you have associated with the resource.
    action: ResponseAction,

    /// Indicates whether automatic application layer DDoS mitigation is enabled for
    /// the protection.
    status: ApplicationLayerAutomaticResponseStatus,

    pub const json_field_names = .{
        .action = "Action",
        .status = "Status",
    };
};
