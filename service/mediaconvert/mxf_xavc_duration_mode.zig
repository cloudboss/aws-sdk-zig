const std = @import("std");

/// To create an output that complies with the XAVC file format guidelines for
/// interoperability, keep the default value, Drop frames for compliance. To
/// include all frames from your input in this output, keep the default setting,
/// Allow any duration. The number of frames that MediaConvert excludes when you
/// set this to Drop frames for compliance depends on the output frame rate and
/// duration.
pub const MxfXavcDurationMode = enum {
    allow_any_duration,
    drop_frames_for_compliance,

    pub const json_field_names = .{
        .allow_any_duration = "ALLOW_ANY_DURATION",
        .drop_frames_for_compliance = "DROP_FRAMES_FOR_COMPLIANCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allow_any_duration => "ALLOW_ANY_DURATION",
            .drop_frames_for_compliance => "DROP_FRAMES_FOR_COMPLIANCE",
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
