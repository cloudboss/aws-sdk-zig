const std = @import("std");

pub const RegistrationAssociationBehavior = enum {
    associate_before_submit,
    associate_on_approval,
    associate_after_complete,

    pub const json_field_names = .{
        .associate_before_submit = "ASSOCIATE_BEFORE_SUBMIT",
        .associate_on_approval = "ASSOCIATE_ON_APPROVAL",
        .associate_after_complete = "ASSOCIATE_AFTER_COMPLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associate_before_submit => "ASSOCIATE_BEFORE_SUBMIT",
            .associate_on_approval => "ASSOCIATE_ON_APPROVAL",
            .associate_after_complete => "ASSOCIATE_AFTER_COMPLETE",
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
