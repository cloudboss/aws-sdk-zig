/// Rtmp Caption Data
pub const RtmpCaptionData = enum {
    all,
    field1_608,
    field1_and_field2_608,

    pub const json_field_names = .{
        .all = "ALL",
        .field1_608 = "FIELD1_608",
        .field1_and_field2_608 = "FIELD1_AND_FIELD2_608",
    };
};
