const std = @import("std");

/// Specifies whether the pricing plan for the queue is on-demand or reserved.
/// For on-demand, you pay per minute, billed in increments of .01 minute. For
/// reserved, you pay for the transcoding capacity of the entire queue,
/// regardless of how much or how little you use it. Reserved pricing requires a
/// 12-month commitment.
pub const PricingPlan = enum {
    on_demand,
    reserved,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .reserved = "RESERVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_demand => "ON_DEMAND",
            .reserved => "RESERVED",
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
