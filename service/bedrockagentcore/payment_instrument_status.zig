const std = @import("std");

/// The status of a payment instrument.
pub const PaymentInstrumentStatus = enum {
    initiated,
    active,
    failed,
    deleted,
    blocked,

    pub const json_field_names = .{
        .initiated = "INITIATED",
        .active = "ACTIVE",
        .failed = "FAILED",
        .deleted = "DELETED",
        .blocked = "BLOCKED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initiated => "INITIATED",
            .active => "ACTIVE",
            .failed => "FAILED",
            .deleted => "DELETED",
            .blocked => "BLOCKED",
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
