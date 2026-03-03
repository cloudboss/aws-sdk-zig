const std = @import("std");

pub const EntityExemptionAccountStatus = enum {
    none,
    valid,
    expired,
    pending,

    pub const json_field_names = .{
        .none = "None",
        .valid = "Valid",
        .expired = "Expired",
        .pending = "Pending",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "None",
            .valid => "Valid",
            .expired => "Expired",
            .pending => "Pending",
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
