const std = @import("std");

pub const MultiRegionAccessPointStatus = enum {
    ready,
    inconsistent_across_regions,
    creating,
    partially_created,
    partially_deleted,
    deleting,

    pub const json_field_names = .{
        .ready = "READY",
        .inconsistent_across_regions = "INCONSISTENT_ACROSS_REGIONS",
        .creating = "CREATING",
        .partially_created = "PARTIALLY_CREATED",
        .partially_deleted = "PARTIALLY_DELETED",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready => "READY",
            .inconsistent_across_regions => "INCONSISTENT_ACROSS_REGIONS",
            .creating => "CREATING",
            .partially_created => "PARTIALLY_CREATED",
            .partially_deleted => "PARTIALLY_DELETED",
            .deleting => "DELETING",
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
