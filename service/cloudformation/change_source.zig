const std = @import("std");

pub const ChangeSource = enum {
    resource_reference,
    parameter_reference,
    resource_attribute,
    direct_modification,
    automatic,
    no_modification,

    pub const json_field_names = .{
        .resource_reference = "ResourceReference",
        .parameter_reference = "ParameterReference",
        .resource_attribute = "ResourceAttribute",
        .direct_modification = "DirectModification",
        .automatic = "Automatic",
        .no_modification = "NoModification",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_reference => "ResourceReference",
            .parameter_reference => "ParameterReference",
            .resource_attribute => "ResourceAttribute",
            .direct_modification => "DirectModification",
            .automatic => "Automatic",
            .no_modification => "NoModification",
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
