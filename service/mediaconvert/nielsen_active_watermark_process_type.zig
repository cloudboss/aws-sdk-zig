const std = @import("std");

/// Choose the type of Nielsen watermarks that you want in your outputs. When
/// you choose NAES 2 and NW, you must provide a value for the setting SID. When
/// you choose CBET, you must provide a value for the setting CSID. When you
/// choose NAES 2, NW, and CBET, you must provide values for both of these
/// settings.
pub const NielsenActiveWatermarkProcessType = enum {
    naes2_and_nw,
    cbet,
    naes2_and_nw_and_cbet,

    pub const json_field_names = .{
        .naes2_and_nw = "NAES2_AND_NW",
        .cbet = "CBET",
        .naes2_and_nw_and_cbet = "NAES2_AND_NW_AND_CBET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .naes2_and_nw => "NAES2_AND_NW",
            .cbet => "CBET",
            .naes2_and_nw_and_cbet => "NAES2_AND_NW_AND_CBET",
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
