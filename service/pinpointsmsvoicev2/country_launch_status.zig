const std = @import("std");

/// The per-country launch status of an RCS agent.
///
/// * `CREATED`: The country launch has been created.
/// * `PENDING`: The country launch is pending.
/// * `PARTIAL`: The country launch is partially active.
/// * `ACTIVE`: The country launch is active.
/// * `REJECTED`: The country launch was rejected.
pub const CountryLaunchStatus = enum {
    created,
    pending,
    partial,
    active,
    rejected,

    pub const json_field_names = .{
        .created = "CREATED",
        .pending = "PENDING",
        .partial = "PARTIAL",
        .active = "ACTIVE",
        .rejected = "REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .pending => "PENDING",
            .partial => "PARTIAL",
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
