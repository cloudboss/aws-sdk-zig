const std = @import("std");

/// Set PSI control for transport stream inputs to specify which data the demux
/// process to scans.
/// * Ignore PSI - Scan all PIDs for audio and video.
/// * Use PSI - Scan only PSI data.
pub const InputPsiControl = enum {
    ignore_psi,
    use_psi,

    pub const json_field_names = .{
        .ignore_psi = "IGNORE_PSI",
        .use_psi = "USE_PSI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ignore_psi => "IGNORE_PSI",
            .use_psi => "USE_PSI",
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
