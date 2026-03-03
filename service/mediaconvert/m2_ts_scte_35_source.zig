const std = @import("std");

/// For SCTE-35 markers from your input-- Choose Passthrough if you want SCTE-35
/// markers that appear in your input to also appear in this output. Choose None
/// if you don't want SCTE-35 markers in this output. For SCTE-35 markers from
/// an ESAM XML document-- Choose None. Also provide the ESAM XML as a string in
/// the setting Signal processing notification XML. Also enable ESAM SCTE-35
/// (include the property scte35Esam).
pub const M2tsScte35Source = enum {
    passthrough,
    none,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
            .none => "NONE",
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
