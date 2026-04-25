const std = @import("std");

/// The carrier-level launch status.
///
/// * `PENDING`: The carrier launch is pending.
/// * `ACTIVE`: The carrier launch is active.
/// * `REJECTED`: The carrier launch was rejected.
pub const CarrierStatus = enum {
    pending,
    active,
    rejected,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .rejected = "REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .active => "ACTIVE",
            .rejected => "REJECTED",
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
