const std = @import("std");

/// If the location of parameter set NAL units doesn't matter in your workflow,
/// ignore this setting. Use this setting only with CMAF or DASH outputs, or
/// with standalone file outputs in an MPEG-4 container (MP4 outputs). Choose
/// HVC1 to mark your output as HVC1. This makes your output compliant with the
/// following specification: ISO IECJTC1 SC29 N13798 Text ISO/IEC FDIS 14496-15
/// 3rd Edition. For these outputs, the service stores parameter set NAL units
/// in the sample headers but not in the samples directly. For MP4 outputs, when
/// you choose HVC1, your output video might not work properly with some
/// downstream systems and video players. The service defaults to marking your
/// output as HEV1. For these outputs, the service writes parameter set NAL
/// units directly into the samples.
pub const H265WriteMp4PackagingType = enum {
    hvc1,
    hev1,

    pub const json_field_names = .{
        .hvc1 = "HVC1",
        .hev1 = "HEV1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hvc1 => "HVC1",
            .hev1 => "HEV1",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
