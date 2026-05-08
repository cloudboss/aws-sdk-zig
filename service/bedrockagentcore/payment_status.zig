const std = @import("std");

/// Transaction status enum
pub const PaymentStatus = enum {
    proof_generated,

    pub const json_field_names = .{
        .proof_generated = "PROOF_GENERATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .proof_generated => "PROOF_GENERATED",
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
