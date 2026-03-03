const std = @import("std");

/// Choose how the service does stereo downmixing. This setting only applies if
/// you keep the default value of 3/2 - L, R, C, Ls, Rs for the setting Coding
/// mode. If you choose a different value for Coding mode, the service ignores
/// Stereo downmix.
pub const Eac3StereoDownmix = enum {
    not_indicated,
    lo_ro,
    lt_rt,
    dpl2,

    pub const json_field_names = .{
        .not_indicated = "NOT_INDICATED",
        .lo_ro = "LO_RO",
        .lt_rt = "LT_RT",
        .dpl2 = "DPL2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_indicated => "NOT_INDICATED",
            .lo_ro => "LO_RO",
            .lt_rt => "LT_RT",
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
