const std = @import("std");

pub const TaxRegistrationStatus = enum {
    verified,
    pending,
    deleted,
    rejected,

    pub const json_field_names = .{
        .verified = "Verified",
        .pending = "Pending",
        .deleted = "Deleted",
        .rejected = "Rejected",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .verified => "Verified",
            .pending => "Pending",
            .deleted => "Deleted",
            .rejected => "Rejected",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
