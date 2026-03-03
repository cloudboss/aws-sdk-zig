const std = @import("std");

/// When you have a progressive segmented frame (PsF) input, use this setting to
/// flag the input as PsF. MediaConvert doesn't automatically detect PsF.
/// Therefore, flagging your input as PsF results in better preservation of
/// video quality when you do deinterlacing and frame rate conversion. If you
/// don't specify, the default value is Auto. Auto is the correct setting for
/// all inputs that are not PsF. Don't set this value to PsF when your input is
/// interlaced. Doing so creates horizontal interlacing artifacts.
pub const InputScanType = enum {
    auto,
    psf,

    pub const json_field_names = .{
        .auto = "AUTO",
        .psf = "PSF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .psf => "PSF",
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
