const std = @import("std");

/// The filter key to use when listing tenants. This can be one of the
/// following:
///
/// * `TENANT_NAME_CONTAINS` – Filter by a substring of the tenant name.
///
/// * `SENDING_STATUS` – Filter by sending status.
pub const ListTenantsFilterKey = enum {
    tenant_name_contains,
    sending_status,

    pub const json_field_names = .{
        .tenant_name_contains = "TENANT_NAME_CONTAINS",
        .sending_status = "SENDING_STATUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tenant_name_contains => "TENANT_NAME_CONTAINS",
            .sending_status => "SENDING_STATUS",
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
