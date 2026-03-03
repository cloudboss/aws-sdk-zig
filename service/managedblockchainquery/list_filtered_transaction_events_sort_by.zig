const std = @import("std");

pub const ListFilteredTransactionEventsSortBy = enum {
    /// Timestamp of a transaction
    blockchain_instant,

    pub const json_field_names = .{
        .blockchain_instant = "blockchainInstant",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .blockchain_instant => "blockchainInstant",
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
