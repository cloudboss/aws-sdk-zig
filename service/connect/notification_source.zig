const std = @import("std");

/// The source that created the notification. Possible values include CUSTOMER
/// (user-created), RULES (rule-generated), and SYSTEM (system-generated).
pub const NotificationSource = enum {
    customer,
    rules,
    system,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .rules = "RULES",
        .system = "SYSTEM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer => "CUSTOMER",
            .rules => "RULES",
            .system => "SYSTEM",
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
