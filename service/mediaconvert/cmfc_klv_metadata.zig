const std = @import("std");

/// To include key-length-value metadata in this output: Set KLV metadata
/// insertion to Passthrough. MediaConvert reads KLV metadata present in your
/// input and writes each instance to a separate event message box in the
/// output, according to MISB ST1910.1. To exclude this KLV metadata: Set KLV
/// metadata insertion to None or leave blank.
pub const CmfcKlvMetadata = enum {
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
