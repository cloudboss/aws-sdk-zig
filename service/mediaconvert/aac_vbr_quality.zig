/// Specify the quality of your variable bitrate (VBR) AAC audio. For a list of
/// approximate VBR bitrates, see:
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/aac-support.html#aac_vbr
pub const AacVbrQuality = enum {
    low,
    medium_low,
    medium_high,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .medium_low = "MEDIUM_LOW",
        .medium_high = "MEDIUM_HIGH",
        .high = "HIGH",
    };
};
