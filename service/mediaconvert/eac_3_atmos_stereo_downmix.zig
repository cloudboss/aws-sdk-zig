const std = @import("std");

/// Choose how the service does stereo downmixing. Default value: Not indicated
/// Related setting: To have MediaConvert use this value, keep the default
/// value, Custom for the setting Downmix control. Otherwise, MediaConvert
/// ignores Stereo downmix.
pub const Eac3AtmosStereoDownmix = enum {
    not_indicated,
    stereo,
    surround,
    dpl2,

    pub const json_field_names = .{
        .not_indicated = "NOT_INDICATED",
        .stereo = "STEREO",
        .surround = "SURROUND",
        .dpl2 = "DPL2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_indicated => "NOT_INDICATED",
            .stereo => "STEREO",
            .surround => "SURROUND",
            .dpl2 => "DPL2",
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
