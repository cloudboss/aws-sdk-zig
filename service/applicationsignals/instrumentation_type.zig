const std = @import("std");

/// Type of instrumentation configuration
pub const InstrumentationType = enum {
    /// Temporary instrumentation that expires automatically (default 24 hours)
    breakpoint,
    /// Permanent instrumentation that persists until explicitly deleted
    probe,

    pub const json_field_names = .{
        .breakpoint = "BREAKPOINT",
        .probe = "PROBE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .breakpoint => "BREAKPOINT",
            .probe => "PROBE",
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
