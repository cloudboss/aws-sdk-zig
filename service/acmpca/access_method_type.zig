const std = @import("std");

pub const AccessMethodType = enum {
    ca_repository,
    resource_pki_manifest,
    resource_pki_notify,

    pub const json_field_names = .{
        .ca_repository = "CA_REPOSITORY",
        .resource_pki_manifest = "RESOURCE_PKI_MANIFEST",
        .resource_pki_notify = "RESOURCE_PKI_NOTIFY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ca_repository => "CA_REPOSITORY",
            .resource_pki_manifest => "RESOURCE_PKI_MANIFEST",
            .resource_pki_notify => "RESOURCE_PKI_NOTIFY",
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
