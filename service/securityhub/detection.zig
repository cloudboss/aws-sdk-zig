const Sequence = @import("sequence.zig").Sequence;

/// A top-level object field that provides details about an Amazon GuardDuty
/// Extended Threat Detection attack sequence. GuardDuty generates an attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const Detection = struct {
    /// Provides details about an attack sequence.
    sequence: ?Sequence,

    pub const json_field_names = .{
        .sequence = "Sequence",
    };
};
