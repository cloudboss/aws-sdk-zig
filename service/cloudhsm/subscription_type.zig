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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
