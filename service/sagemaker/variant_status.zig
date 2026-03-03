const std = @import("std");

pub const VariantStatus = enum {
    creating,
    updating,
    deleting,
    activating_traffic,
    baking,

    pub const json_field_names = .{
        .creating = "Creating",
        .updating = "Updating",
        .deleting = "Deleting",
        .activating_traffic = "ActivatingTraffic",
        .baking = "Baking",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .updating => "Updating",
            .deleting => "Deleting",
            .activating_traffic => "ActivatingTraffic",
            .baking => "Baking",
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
