const std = @import("std");

pub const ActionEnum = enum {
    create,
    update_metadata,
    active,
    inactive,
    delete,
    under_review,
    reviewed,
    import_evidence,

    pub const json_field_names = .{
        .create = "CREATE",
        .update_metadata = "UPDATE_METADATA",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .delete = "DELETE",
        .under_review = "UNDER_REVIEW",
        .reviewed = "REVIEWED",
        .import_evidence = "IMPORT_EVIDENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create => "CREATE",
            .update_metadata => "UPDATE_METADATA",
            .active => "ACTIVE",
            .inactive => "INACTIVE",
            .delete => "DELETE",
            .under_review => "UNDER_REVIEW",
            .reviewed => "REVIEWED",
            .import_evidence => "IMPORT_EVIDENCE",
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
