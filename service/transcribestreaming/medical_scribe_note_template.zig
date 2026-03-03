const std = @import("std");

pub const MedicalScribeNoteTemplate = enum {
    history_and_physical,
    girpp,
    dap,
    sirp,
    birp,
    behavioral_soap,
    physical_soap,

    pub const json_field_names = .{
        .history_and_physical = "HISTORY_AND_PHYSICAL",
        .girpp = "GIRPP",
        .dap = "DAP",
        .sirp = "SIRP",
        .birp = "BIRP",
        .behavioral_soap = "BEHAVIORAL_SOAP",
        .physical_soap = "PHYSICAL_SOAP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .history_and_physical => "HISTORY_AND_PHYSICAL",
            .girpp => "GIRPP",
            .dap => "DAP",
            .sirp => "SIRP",
            .birp => "BIRP",
            .behavioral_soap => "BEHAVIORAL_SOAP",
            .physical_soap => "PHYSICAL_SOAP",
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
