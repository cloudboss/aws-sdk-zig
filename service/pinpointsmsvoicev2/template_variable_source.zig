const std = @import("std");

/// The source of a template variable value.
///
/// * `CUSTOMER` - The variable value is provided by the customer.
/// * `SYSTEM` - The variable value is provided by the system.
pub const TemplateVariableSource = enum {
    customer,
    system,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .system = "SYSTEM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer => "CUSTOMER",
            .system => "SYSTEM",
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
