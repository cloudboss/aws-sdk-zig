const std = @import("std");

pub const ResourceTypeForTagging = enum {
    document,
    managed_instance,
    maintenance_window,
    parameter,
    patch_baseline,
    ops_item,
    opsmetadata,
    automation,
    association,

    pub const json_field_names = .{
        .document = "Document",
        .managed_instance = "ManagedInstance",
        .maintenance_window = "MaintenanceWindow",
        .parameter = "Parameter",
        .patch_baseline = "PatchBaseline",
        .ops_item = "OpsItem",
        .opsmetadata = "OpsMetadata",
        .automation = "Automation",
        .association = "Association",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .document => "Document",
            .managed_instance => "ManagedInstance",
            .maintenance_window => "MaintenanceWindow",
            .parameter => "Parameter",
            .patch_baseline => "PatchBaseline",
            .ops_item => "OpsItem",
            .opsmetadata => "OpsMetadata",
            .automation => "Automation",
            .association => "Association",
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
