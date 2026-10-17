const std = @import("std");

pub const VideoTransferCharacteristics = enum {
    bt709,
    bt470_m,
    bt470_bg,
    bt601,
    smpte240_m,
    linear,
    log100,
    log316,
    iec61966_2_4,
    bt1361_ecg,
    iec61966_2_1,
    bt2020_10,
    bt2020_12,
    bt2100_pq,
    smpte428,
    bt2100_hlg,

    pub const json_field_names = .{
        .bt709 = "BT709",
        .bt470_m = "BT470M",
        .bt470_bg = "BT470BG",
        .bt601 = "BT601",
        .smpte240_m = "SMPTE240M",
        .linear = "LINEAR",
        .log100 = "LOG100",
        .log316 = "LOG316",
        .iec61966_2_4 = "IEC61966_2_4",
        .bt1361_ecg = "BT1361_ECG",
        .iec61966_2_1 = "IEC61966_2_1",
        .bt2020_10 = "BT2020_10",
        .bt2020_12 = "BT2020_12",
        .bt2100_pq = "BT2100_PQ",
        .smpte428 = "SMPTE428",
        .bt2100_hlg = "BT2100_HLG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bt709 => "BT709",
            .bt470_m => "BT470M",
            .bt470_bg => "BT470BG",
            .bt601 => "BT601",
            .smpte240_m => "SMPTE240M",
            .linear => "LINEAR",
            .log100 => "LOG100",
            .log316 => "LOG316",
            .iec61966_2_4 => "IEC61966_2_4",
            .bt1361_ecg => "BT1361_ECG",
            .iec61966_2_1 => "IEC61966_2_1",
            .bt2020_10 => "BT2020_10",
            .bt2020_12 => "BT2020_12",
            .bt2100_pq => "BT2100_PQ",
            .smpte428 => "SMPTE428",
            .bt2100_hlg => "BT2100_HLG",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
