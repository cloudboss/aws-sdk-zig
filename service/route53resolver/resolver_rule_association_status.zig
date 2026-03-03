const std = @import("std");

pub const ResolverRuleAssociationStatus = enum {
    creating,
    complete,
    deleting,
    failed,
    overridden,

    pub const json_field_names = .{
        .creating = "CREATING",
        .complete = "COMPLETE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .overridden = "OVERRIDDEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .complete => "COMPLETE",
            .deleting => "DELETING",
            .failed => "FAILED",
            .overridden => "OVERRIDDEN",
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
