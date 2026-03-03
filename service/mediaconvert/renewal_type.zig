const std = @import("std");

/// Specifies whether the term of your reserved queue pricing plan is
/// automatically extended (AUTO_RENEW) or expires (EXPIRE) at the end of the
/// term.
pub const RenewalType = enum {
    auto_renew,
    expire,

    pub const json_field_names = .{
        .auto_renew = "AUTO_RENEW",
        .expire = "EXPIRE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto_renew => "AUTO_RENEW",
            .expire => "EXPIRE",
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
