/// Specify how SPS and PPS NAL units are written in your output MP4 container,
/// according to ISO/IEC 14496-15. If the location of these parameters doesn't
/// matter in your workflow: Keep the default value, AVC1. MediaConvert writes
/// SPS and PPS NAL units in the sample description ('stsd') box (but not into
/// samples directly). To write SPS and PPS NAL units directly into samples (but
/// not in the 'stsd' box): Choose AVC3. When you do, note that your output
/// might not play properly with some downstream systems or players.
pub const H264WriteMp4PackagingType = enum {
    avc1,
    avc3,

    pub const json_field_names = .{
        .avc1 = "AVC1",
        .avc3 = "AVC3",
    };
};
