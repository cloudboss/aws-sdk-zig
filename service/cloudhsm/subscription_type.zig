const std = @import("std");

/// Specifies the type of subscription for the HSM.
///
/// * **PRODUCTION** - The HSM is being used in a production
/// environment.
///
/// * **TRIAL** - The HSM is being used in a product
/// trial.
pub const SubscriptionType = enum {
    production,

    pub const json_field_names = .{
        .production = "PRODUCTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .production => "PRODUCTION",
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
