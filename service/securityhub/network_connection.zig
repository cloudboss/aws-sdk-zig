const ConnectionDirection = @import("connection_direction.zig").ConnectionDirection;

/// Contains information about the network connection involved in an Amazon
/// GuardDuty Extended Threat Detection attack sequence. GuardDuty generates an
/// attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const NetworkConnection = struct {
    /// The direction in which the network traffic is flowing.
    direction: ?ConnectionDirection,

    pub const json_field_names = .{
        .direction = "Direction",
    };
};
