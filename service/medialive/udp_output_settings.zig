const UdpContainerSettings = @import("udp_container_settings.zig").UdpContainerSettings;
const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;
const FecOutputSettings = @import("fec_output_settings.zig").FecOutputSettings;

/// Udp Output Settings
pub const UdpOutputSettings = struct {
    /// UDP output buffering in milliseconds. Larger values increase latency through
    /// the transcoder but simultaneously assist the transcoder in maintaining a
    /// constant, low-jitter UDP/RTP output while accommodating clock recovery,
    /// input switching, input disruptions, picture reordering, etc.
    buffer_msec: ?i32,

    container_settings: UdpContainerSettings,

    /// Destination address and port number for RTP or UDP packets. Can be unicast
    /// or multicast RTP or UDP (eg. rtp://239.10.10.10:5001 or
    /// udp://10.100.100.100:5002).
    destination: OutputLocationRef,

    /// Settings for enabling and adjusting Forward Error Correction on UDP outputs.
    fec_output_settings: ?FecOutputSettings,

    pub const json_field_names = .{
        .buffer_msec = "BufferMsec",
        .container_settings = "ContainerSettings",
        .destination = "Destination",
        .fec_output_settings = "FecOutputSettings",
    };
};
