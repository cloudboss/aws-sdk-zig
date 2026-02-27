const SegmentActionServiceInsertion = @import("segment_action_service_insertion.zig").SegmentActionServiceInsertion;
const SendViaMode = @import("send_via_mode.zig").SendViaMode;
const Via = @import("via.zig").Via;
const WhenSentTo = @import("when_sent_to.zig").WhenSentTo;

/// Describes the action that the service insertion will take for any segments
/// associated with it.
pub const ServiceInsertionAction = struct {
    /// The action the service insertion takes for traffic.
    /// `send-via` sends east-west traffic between attachments.
    /// `send-to` sends north-south traffic to the
    /// security appliance, and then from that to either the Internet or to an
    /// on-premesis
    /// location.
    action: ?SegmentActionServiceInsertion,

    /// Describes the mode packets take for the `send-via` action. This is not used
    /// when the action is `send-to`. `dual-hop` packets traverse attachments in
    /// both the source to the destination core network edges. This mode requires
    /// that an inspection attachment must be present in all Regions of the service
    /// insertion-enabled segments.
    /// For `single-hop`, packets traverse a single intermediate inserted
    /// attachment. You can use `EdgeOverride` to specify a specific edge to use.
    mode: ?SendViaMode,

    /// The list of network function groups and any edge overrides for the chosen
    /// service
    /// insertion action. Used for both `send-to` or `send-via`.
    via: ?Via,

    /// The list of destination segments if the service insertion action is
    /// `send-via`.
    when_sent_to: ?WhenSentTo,

    pub const json_field_names = .{
        .action = "Action",
        .mode = "Mode",
        .via = "Via",
        .when_sent_to = "WhenSentTo",
    };
};
