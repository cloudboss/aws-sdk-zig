const std = @import("std");

/// The type of entity for which to retrieve insights. Possible values are
/// `Account` and `DomainName`.
pub const InsightEntityType = enum {
    account,
    domain,

    pub const json_field_names = .{
        .account = "Account",
        .domain = "DomainName",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "Account",
            .domain => "DomainName",
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
