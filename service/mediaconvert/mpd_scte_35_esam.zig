const std = @import("std");

/// Use this setting only when you specify SCTE-35 markers from ESAM. Choose
/// INSERT to put SCTE-35 markers in this output at the insertion points that
/// you specify in an ESAM XML document. Provide the document in the setting SCC
/// XML.
pub const MpdScte35Esam = enum {
    insert,
    none,

    pub const json_field_names = .{
        .insert = "INSERT",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insert => "INSERT",
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
