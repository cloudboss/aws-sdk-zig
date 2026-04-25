const Actor = @import("actor.zig").Actor;
const NetworkEndpoint = @import("network_endpoint.zig").NetworkEndpoint;
const Indicator = @import("indicator.zig").Indicator;
const Signal = @import("signal.zig").Signal;

/// Contains information about an Amazon GuardDuty Extended Threat Detection
/// attack sequence finding. GuardDuty generates an attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub
/// CSPM, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const Sequence = struct {
    /// Provides information about the actors involved in the attack sequence.
    actors: ?[]const Actor = null,

    /// Contains information about the network endpoints that were used in the
    /// attack sequence.
    endpoints: ?[]const NetworkEndpoint = null,

    /// Contains information about the indicators observed in the attack sequence.
    /// The values for
    /// [SignalIndicators](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_Signal.html) are a subset of the values for `SequenceIndicators`, but the values for
    /// these fields don't always match 1:1.
    sequence_indicators: ?[]const Indicator = null,

    /// Contains information about the signals involved in the attack sequence.
    signals: ?[]const Signal = null,

    /// Unique identifier of the attack sequence.
    uid: ?[]const u8 = null,

    pub const json_field_names = .{
        .actors = "Actors",
        .endpoints = "Endpoints",
        .sequence_indicators = "SequenceIndicators",
        .signals = "Signals",
        .uid = "Uid",
    };
};
