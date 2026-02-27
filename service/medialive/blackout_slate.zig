const InputLocation = @import("input_location.zig").InputLocation;
const BlackoutSlateNetworkEndBlackout = @import("blackout_slate_network_end_blackout.zig").BlackoutSlateNetworkEndBlackout;
const BlackoutSlateState = @import("blackout_slate_state.zig").BlackoutSlateState;

/// Blackout Slate
pub const BlackoutSlate = struct {
    /// Blackout slate image to be used. Leave empty for solid black. Only bmp and
    /// png images are supported.
    blackout_slate_image: ?InputLocation,

    /// Setting to enabled causes the encoder to blackout the video, audio, and
    /// captions, and raise the "Network Blackout Image" slate when an SCTE104/35
    /// Network End Segmentation Descriptor is encountered. The blackout will be
    /// lifted when the Network Start Segmentation Descriptor is encountered. The
    /// Network End and Network Start descriptors must contain a network ID that
    /// matches the value entered in "Network ID".
    network_end_blackout: ?BlackoutSlateNetworkEndBlackout,

    /// Path to local file to use as Network End Blackout image. Image will be
    /// scaled to fill the entire output raster.
    network_end_blackout_image: ?InputLocation,

    /// Provides Network ID that matches EIDR ID format (e.g.,
    /// "10.XXXX/XXXX-XXXX-XXXX-XXXX-XXXX-C").
    network_id: ?[]const u8,

    /// When set to enabled, causes video, audio and captions to be blanked when
    /// indicated by program metadata.
    state: ?BlackoutSlateState,

    pub const json_field_names = .{
        .blackout_slate_image = "BlackoutSlateImage",
        .network_end_blackout = "NetworkEndBlackout",
        .network_end_blackout_image = "NetworkEndBlackoutImage",
        .network_id = "NetworkId",
        .state = "State",
    };
};
