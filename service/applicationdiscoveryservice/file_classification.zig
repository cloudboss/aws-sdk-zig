const std = @import("std");

pub const FileClassification = enum {
    modelizeit_export,
    rvtools_export,
    vmware_nsx_export,
    import_template,

    pub const json_field_names = .{
        .modelizeit_export = "MODELIZEIT_EXPORT",
        .rvtools_export = "RVTOOLS_EXPORT",
        .vmware_nsx_export = "VMWARE_NSX_EXPORT",
        .import_template = "IMPORT_TEMPLATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .modelizeit_export => "MODELIZEIT_EXPORT",
            .rvtools_export => "RVTOOLS_EXPORT",
            .vmware_nsx_export => "VMWARE_NSX_EXPORT",
            .import_template => "IMPORT_TEMPLATE",
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
