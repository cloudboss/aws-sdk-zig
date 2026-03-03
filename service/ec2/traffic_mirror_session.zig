const Tag = @import("tag.zig").Tag;

/// Describes a Traffic Mirror session.
pub const TrafficMirrorSession = struct {
    /// The description of the Traffic Mirror session.
    description: ?[]const u8 = null,

    /// The ID of the Traffic Mirror session's network interface.
    network_interface_id: ?[]const u8 = null,

    /// The ID of the account that owns the Traffic Mirror session.
    owner_id: ?[]const u8 = null,

    /// The number of bytes in each packet to mirror. These are the bytes after the
    /// VXLAN header. To mirror a subset, set this to the length (in bytes) to
    /// mirror. For example, if you set this value to 100, then the first 100 bytes
    /// that meet the filter criteria are copied to the target. Do not specify this
    /// parameter when you want to mirror the entire packet
    packet_length: ?i32 = null,

    /// The session number determines the order in which sessions are evaluated when
    /// an interface is used by multiple sessions. The first session with a matching
    /// filter is the one that mirrors the packets.
    ///
    /// Valid values are 1-32766.
    session_number: ?i32 = null,

    /// The tags assigned to the Traffic Mirror session.
    tags: ?[]const Tag = null,

    /// The ID of the Traffic Mirror filter.
    traffic_mirror_filter_id: ?[]const u8 = null,

    /// The ID for the Traffic Mirror session.
    traffic_mirror_session_id: ?[]const u8 = null,

    /// The ID of the Traffic Mirror target.
    traffic_mirror_target_id: ?[]const u8 = null,

    /// The virtual network ID associated with the Traffic Mirror session.
    virtual_network_id: ?i32 = null,
};
