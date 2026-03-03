const std = @import("std");

pub const ComponentType = enum {
    hana,
    hana_node,
    abap,
    ascs,
    dialog,
    webdisp,
    wd,
    ers,

    pub const json_field_names = .{
        .hana = "HANA",
        .hana_node = "HANA_NODE",
        .abap = "ABAP",
        .ascs = "ASCS",
        .dialog = "DIALOG",
        .webdisp = "WEBDISP",
        .wd = "WD",
        .ers = "ERS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hana => "HANA",
            .hana_node => "HANA_NODE",
            .abap => "ABAP",
            .ascs => "ASCS",
            .dialog => "DIALOG",
            .webdisp => "WEBDISP",
            .wd => "WD",
            .ers => "ERS",
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
