const std = @import("std");

/// The precedence used when a client-supplied query parameter has the same name
/// as a configured static query parameter:
///
/// * `CLIENT_OVERRIDE` - The client-supplied value overrides the configured
///   static value for that parameter name. This is the default.
/// * `STATIC_OVERRIDE` - The configured static value is retained, overriding
///   the client-supplied value for that parameter name.
pub const StaticQueryParameterConflictResolution = enum {
    client_override,
    static_override,

    pub const json_field_names = .{
        .client_override = "CLIENT_OVERRIDE",
        .static_override = "STATIC_OVERRIDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_override => "CLIENT_OVERRIDE",
            .static_override => "STATIC_OVERRIDE",
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
