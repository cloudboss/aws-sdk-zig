/// AUTO will select the highest bitrate input in the video selector source.
/// REMUX_ALL will passthrough all the selected streams in the video selector
/// source. When selecting streams from multiple renditions (i.e. using Stream
/// video selector type): REMUX_ALL will only remux all streams selected, and
/// AUTO will use the highest bitrate video stream among the selected streams as
/// source.
pub const VideoSelectorMode = enum {
    auto,
    remux_all,

    pub const json_field_names = .{
        .auto = "AUTO",
        .remux_all = "REMUX_ALL",
    };
};
