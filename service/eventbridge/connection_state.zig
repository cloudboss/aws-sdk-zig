const std = @import("std");

pub const ConnectionState = enum {
    creating,
    updating,
    deleting,
    authorized,
    deauthorized,
    authorizing,
    deauthorizing,
    active,
    failed_connectivity,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .authorized = "AUTHORIZED",
        .deauthorized = "DEAUTHORIZED",
        .authorizing = "AUTHORIZING",
        .deauthorizing = "DEAUTHORIZING",
        .active = "ACTIVE",
        .failed_connectivity = "FAILED_CONNECTIVITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .authorized => "AUTHORIZED",
            .deauthorized => "DEAUTHORIZED",
            .authorizing => "AUTHORIZING",
            .deauthorizing => "DEAUTHORIZING",
            .active => "ACTIVE",
            .failed_connectivity => "FAILED_CONNECTIVITY",
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
