/// Specify the initial presentation timestamp (PTS) offset for your transport
/// stream output. To let MediaConvert automatically determine the initial PTS
/// offset: Keep the default value, Auto. We recommend that you choose Auto for
/// the widest player compatibility. The initial PTS will be at least two
/// seconds and vary depending on your output's bitrate, HRD buffer size and HRD
/// buffer initial fill percentage. To manually specify an initial PTS offset:
/// Choose Seconds or Milliseconds. Then specify the number of seconds or
/// milliseconds with PTS offset.
pub const TsPtsOffset = enum {
    auto,
    seconds,
    milliseconds,

    pub const json_field_names = .{
        .auto = "AUTO",
        .seconds = "SECONDS",
        .milliseconds = "MILLISECONDS",
    };
};
