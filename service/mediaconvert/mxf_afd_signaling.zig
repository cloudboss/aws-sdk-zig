/// Optional. When you have AFD signaling set up in your output video stream,
/// use this setting to choose whether to also include it in the MXF wrapper.
/// Choose Don't copy to exclude AFD signaling from the MXF wrapper. Choose Copy
/// from video stream to copy the AFD values from the video stream for this
/// output to the MXF wrapper. Regardless of which option you choose, the AFD
/// values remain in the video stream. Related settings: To set up your output
/// to include or exclude AFD values, see AfdSignaling, under VideoDescription.
/// On the console, find AFD signaling under the output's video encoding
/// settings.
pub const MxfAfdSignaling = enum {
    no_copy,
    copy_from_video,

    pub const json_field_names = .{
        .no_copy = "NO_COPY",
        .copy_from_video = "COPY_FROM_VIDEO",
    };
};
