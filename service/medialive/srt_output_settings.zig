const UdpContainerSettings = @import("udp_container_settings.zig").UdpContainerSettings;
const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;
const SrtEncryptionType = @import("srt_encryption_type.zig").SrtEncryptionType;

/// Srt Output Settings
pub const SrtOutputSettings = struct {
    /// SRT output buffering in milliseconds. A higher value increases latency
    /// through the encoder. But the benefits are that it helps to maintain a
    /// constant, low-jitter SRT output, and it accommodates clock recovery, input
    /// switching, input disruptions, picture reordering, and so on. Range: 0-10000
    /// milliseconds.
    buffer_msec: ?i32 = null,

    container_settings: UdpContainerSettings,

    destination: OutputLocationRef,

    /// The encryption level for the content. Valid values are AES128, AES192,
    /// AES256. You and the downstream system should plan how to set this field
    /// because the values must not conflict with each other.
    encryption_type: ?SrtEncryptionType = null,

    /// The latency value, in milliseconds, that is proposed during the SRT
    /// connection handshake. SRT will choose the maximum of the values proposed by
    /// the sender and receiver. On the sender side, latency is the amount of time a
    /// packet is held to give it a chance to be delivered successfully. On the
    /// receiver side, latency is the amount of time the packet is held before
    /// delivering to the application, aiding in packet recovery and matching as
    /// closely as possible the packet timing of the sender. Range: 40-16000
    /// milliseconds.
    latency: ?i32 = null,

    pub const json_field_names = .{
        .buffer_msec = "BufferMsec",
        .container_settings = "ContainerSettings",
        .destination = "Destination",
        .encryption_type = "EncryptionType",
        .latency = "Latency",
    };
};
