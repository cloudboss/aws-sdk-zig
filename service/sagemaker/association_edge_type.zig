const std = @import("std");

pub const AssociationEdgeType = enum {
    contributed_to,
    associated_with,
    derived_from,
    produced,
    same_as,

    pub const json_field_names = .{
        .contributed_to = "ContributedTo",
        .associated_with = "AssociatedWith",
        .derived_from = "DerivedFrom",
        .produced = "Produced",
        .same_as = "SameAs",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contributed_to => "ContributedTo",
            .associated_with => "AssociatedWith",
            .derived_from => "DerivedFrom",
            .produced => "Produced",
            .same_as => "SameAs",
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
