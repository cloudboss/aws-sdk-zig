/// Specify how the value for bandwidth is determined for each video
/// Representation in your output MPD manifest. We recommend that you choose a
/// MPD manifest bandwidth type that is compatible with your downstream player
/// configuration. Max: Use the same value that you specify for Max bitrate in
/// the video output, in bits per second. Average: Use the calculated average
/// bitrate of the encoded video output, in bits per second.
pub const CmafMpdManifestBandwidthType = enum {
    average,
    max,

    pub const json_field_names = .{
        .average = "AVERAGE",
        .max = "MAX",
    };
};
