const Actor = @import("actor.zig").Actor;
const NetworkEndpoint = @import("network_endpoint.zig").NetworkEndpoint;
const ResourceV2 = @import("resource_v2.zig").ResourceV2;
const Indicator = @import("indicator.zig").Indicator;
const Signal = @import("signal.zig").Signal;

/// Contains information about the GuardDuty attack sequence finding.
pub const Sequence = struct {
    /// Contains information about the actors involved in the attack sequence.
    actors: ?[]const Actor = null,

    /// Additional types of sequences that may be associated with the attack
    /// sequence finding,
    /// providing further context about the nature of the detected threat.
    additional_sequence_types: ?[]const []const u8 = null,

    /// Description of the attack sequence.
    description: []const u8,

    /// Contains information about the network endpoints that were used in the
    /// attack sequence.
    endpoints: ?[]const NetworkEndpoint = null,

    /// Contains information about the resources involved in the attack sequence.
    resources: ?[]const ResourceV2 = null,

    /// Contains information about the indicators observed in the attack sequence.
    sequence_indicators: ?[]const Indicator = null,

    /// Contains information about the signals involved in the attack sequence.
    signals: []const Signal,

    /// Unique identifier of the attack sequence.
    uid: []const u8,

    pub const json_field_names = .{
        .actors = "Actors",
        .additional_sequence_types = "AdditionalSequenceTypes",
        .description = "Description",
        .endpoints = "Endpoints",
        .resources = "Resources",
        .sequence_indicators = "SequenceIndicators",
        .signals = "Signals",
        .uid = "Uid",
    };
};
