const std = @import("std");

pub const CustomTemplateBase = enum {
    history_and_physical,
    girpp,
    dap,
    sirp,
    birp,
    behavioral_soap,

    pub const json_field_names = .{
        .history_and_physical = "HISTORY_AND_PHYSICAL",
        .girpp = "GIRPP",
        .dap = "DAP",
        .sirp = "SIRP",
        .birp = "BIRP",
        .behavioral_soap = "BEHAVIORAL_SOAP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .history_and_physical => "HISTORY_AND_PHYSICAL",
            .girpp => "GIRPP",
            .dap => "DAP",
            .sirp => "SIRP",
            .birp => "BIRP",
            .behavioral_soap => "BEHAVIORAL_SOAP",
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
