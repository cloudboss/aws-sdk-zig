const std = @import("std");

pub const ListTransactionsSortBy = enum {
    /// Timestamp of a transaction
    transaction_timestamp,

    pub const json_field_names = .{
        .transaction_timestamp = "TRANSACTION_TIMESTAMP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .transaction_timestamp => "TRANSACTION_TIMESTAMP",
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
